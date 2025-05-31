import 'package:aptyou_ed/bloc/activity_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/navigation_bloc.dart';
import 'firebase_options.dart';
import 'ui/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<NavigationBloc>(create: (_) => NavigationBloc()),
        BlocProvider<ActivityBloc>(create: (_) => ActivityBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return LoginPage();
          },
        ),
      ),
    );
  }
}
