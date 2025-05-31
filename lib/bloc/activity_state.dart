part of 'activity_bloc.dart';

abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final LessonData data;
  final String? selectedWord;

  ActivityLoaded(this.data, {this.selectedWord});
}

class TopicSelected extends ActivityState {
  final LessonData data;
  final String topicIndex;
  final bool isWon;

  TopicSelected(this.data, this.topicIndex, this.isWon);
}

class ActivityError extends ActivityState {
  final String message;

  ActivityError(this.message);
}

class RoundWon extends ActivityState {
  final Artboard artboard;

  RoundWon(this.artboard);
}
