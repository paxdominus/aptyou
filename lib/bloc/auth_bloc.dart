import 'dart:convert';
import 'package:aptyou_ed/model/lesson_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio _dio = Dio();

  AuthBloc() : super(AuthInitial()) {
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<FetchSampleAssets>(_onFetchSampleAssets);
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthFailure(""));

    try {
      // Step 1: Sign in with Google
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthFailure("Google Sign-In cancelled"));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      // Step 2: Get Firebase ID token
      final firebaseIdToken = await firebaseUser?.getIdToken();
      if (firebaseIdToken == null) {
        emit(AuthFailure("Failed to get Firebase ID token"));
        return;
      }

      // Step 3: Get FCM Token
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        emit(AuthFailure("Failed to get FCM token"));
        return;
      }

      // Step 4: Get Device ID
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final deviceId = androidInfo.id; // or use androidId

      // Step 5: Call backend API
      final response = await _dio.post(
        'http://13.60.220.96:8000/auth/v5/firebase/signin',
        options: Options(
          headers: {
            'Authorization': 'Bearer $firebaseIdToken',
            'x-device-id': deviceId,
            'x-fcm-token': fcmToken,
            'x-secret-key': 'uG7pK2aLxX9zR1MvWq3EoJfHdTYcBn84',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = (response.data);

        final accessToken = data['data']['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken.toString());
        emit(AuthSuccess(accessToken));
      } else {
        emit(
          AuthFailure(
            "API Error: ${response.statusCode} ${response.statusMessage}",
          ),
        );
      }
    } catch (e) {
      emit(AuthFailure("Sign-in error: $e"));
    }
  }

  Future<void> _onFetchSampleAssets(
    FetchSampleAssets event,
    Emitter<AuthState> emit,
  ) async {
    emit(AssetsLoading());

    try {
      final response = await Dio().get(
        'http://13.60.220.96:8000/content/v5/sample-assets',
        options: Options(
          headers: {'Authorization': 'Bearer ${event.accessToken}'},
        ),
      );

      if (response.statusCode == 200) {
        try {
          final data = response.data;
          final json = jsonDecode(jsonEncode(data));
          LessonData lessonData = LessonData.fromJson(json['data']);

          emit(AssetsSuccess(lessonData));
        } catch (e, stackTrace) {
          debugPrint("❌ Error parsing LessonData: $e");
          debugPrintStack(stackTrace: stackTrace);
        }
      } else {
        emit(AssetsFailure("Failed to fetch assets: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AssetsFailure("Error fetching assets: $e"));
    }
  }
}
