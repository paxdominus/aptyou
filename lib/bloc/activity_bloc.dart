import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../model/lesson_data.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  LessonData? _cachedData;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isCapSelected = false;
  bool isTaskPlayed = false;
  bool isCapCompleted = false;
  Artboard? _artboard;
  int counter = 0;
  SimpleAnimation? controller;
  bool isSmallTaskReady = false;
  dynamic response;
  dynamic response2;

  ActivityBloc() : super(ActivityInitial()) {
    on<SelectTopicEvent>(_onSelectTopic);
    on<WordSelectedEvent>(_onWordSelected);
    on<LoadActivityWithData>(_onLoadActivityWithData);
    on<RoundWonEvent>(_onRoundWon);
    on<NextRoundEvent>(_onNextRound);
  }

  void _onSelectTopic(
    SelectTopicEvent event,
    Emitter<ActivityState> emit,
  ) async {
    if (_cachedData != null) {
      isTaskPlayed = true;
      _audioPlayer.play(
        UrlSource(
          _cachedData!
              .topics
              .first
              .scriptTags
              .first
              .taskAudioCapitalLetter![Random().nextInt(2)],
        ),
      );
      emit(TopicSelected(_cachedData!, event.topicIndex, false));
      final url = _cachedData!.topics.first.scriptTags.first.cardRewardRive!;

      final url2 =
          _cachedData!.topics.first.scriptTags.first.finalCelebrationRive!;

      response2 = await Dio().get<List<int>>(
        url2,
        options: Options(responseType: ResponseType.bytes),
      );
      response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
    } else {
      emit(ActivityError("No lesson data available."));
    }
  }

  void _onWordSelected(
    WordSelectedEvent event,
    Emitter<ActivityState> emit,
  ) async {
    try {
      if (event.selectedWord == "T") {
        isCapSelected = true;
        isCapCompleted = true;
        await _audioPlayer.play(
          UrlSource(
            _cachedData!
                .topics
                .first
                .scriptTags
                .first
                .correctCapitalAudios![Random().nextInt(6)],
          ),
        );
        isSmallTaskReady = true;
      } else if (event.selectedWord == "t" && isCapCompleted) {
        isCapCompleted = false;
        await _audioPlayer.play(
          UrlSource(
            _cachedData!
                .topics
                .first
                .scriptTags
                .first
                .correctSmallAudios![Random().nextInt(5)],
          ),
        );
        emit(TopicSelected(_cachedData!, event.selectedWord, true));
      } else {
        await _audioPlayer.play(
          UrlSource(
            _cachedData!.topics.first.scriptTags.first.tapWrongAudio![Random()
                .nextInt(2)],
          ),
        );
        emit(TopicSelected(_cachedData!, event.selectedWord, false));
      }
    } catch (e, stackTrace) {
      debugPrint("❌ Error parsing LessonData: $e");
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void _onLoadActivityWithData(
    LoadActivityWithData event,
    Emitter<ActivityState> emit,
  ) async {
    _cachedData = event.lessonData;
    await _audioPlayer.play(
      UrlSource(_cachedData!.topics.first.scriptTags.first.gameIntroAudio!),
    );
    _audioPlayer.onPlayerComplete.listen((event) {
      if (isCapSelected == true && isSmallTaskReady) {
        isSmallTaskReady = false;
        isCapSelected = false;
        _audioPlayer.play(
          UrlSource(
            _cachedData!
                .topics
                .first
                .scriptTags
                .first
                .taskAudioSmallLetter![Random().nextInt(2)],
          ),
        );
      }
    });

    emit(ActivityLoaded(event.lessonData));
  }

  void _onRoundWon(RoundWonEvent event, Emitter<ActivityState> emit) async {
    if (_cachedData != null) {
      try {
        counter++;
        if (counter != 5) {
          _audioPlayer.play(
            UrlSource(
              _cachedData!.topics.first.scriptTags.first.roundPrompts![Random()
                  .nextInt(3)],
            ),
          );
        }
        await RiveFile.initialize();

        if (counter == 5) {
          _audioPlayer.play(
            UrlSource(
              _cachedData!.topics.first.scriptTags.first.finishGameAudio!,
            ),
          );
          final data = Uint8List.fromList(response2.data!);
          final byteData = ByteData.view(data.buffer);
          final file = RiveFile.import(byteData);
          final artboard = file.mainArtboard;

          controller = SimpleAnimation('t5');
          artboard.addController(controller!);
          _artboard = artboard;
          emit(RoundWon(_artboard!));
        } else {
          final data = Uint8List.fromList(response.data!);
          final byteData = ByteData.view(data.buffer);
          final file = RiveFile.import(byteData);
          final artboard = file.mainArtboard;

          controller = SimpleAnimation('t$counter');

          artboard.addController(controller!);
          _artboard = artboard;
          emit(RoundWon(_artboard!));
        }
      } catch (e, stackTrace) {
        debugPrint("❌ Error parsing LessonData: $e");
        debugPrintStack(stackTrace: stackTrace);
      }
    } else {
      emit(ActivityError("No lesson data available."));
    }
  }

  void _onNextRound(NextRoundEvent event, Emitter<ActivityState> emit) async {
    if (_cachedData != null) {
      final completer = Completer();
      try {
        controller!.isActiveChanged.addListener(() {
          if (!controller!.isActive && !completer.isCompleted) {
            completer.complete();
          }
        });
        await completer.future;

        if (counter == 5) {
          emit(
            ActivityLoaded(_cachedData!, selectedWord: "Let's Write letter T"),
          );
        } else {
          emit(TopicSelected(_cachedData!, "index", false));
          isTaskPlayed = true;
          _audioPlayer.play(
            UrlSource(
              _cachedData!
                  .topics
                  .first
                  .scriptTags
                  .first
                  .taskAudioCapitalLetter![Random().nextInt(2)],
            ),
          );
        }
      } catch (e, stackTrace) {
        debugPrint("❌ Error parsing LessonData: $e");
        debugPrintStack(stackTrace: stackTrace);
      }
    } else {
      emit(ActivityError("No lesson data available."));
    }
  }
}
