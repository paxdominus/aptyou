part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent {}

class FetchActivityEvent extends ActivityEvent {}

class SelectTopicEvent extends ActivityEvent {
  final String topicIndex;

  SelectTopicEvent(this.topicIndex);
}

class WordSelectedEvent extends ActivityEvent {
  final String selectedWord;
  WordSelectedEvent(this.selectedWord);
}

class LoadActivityWithData extends ActivityEvent {
  final LessonData lessonData;

  LoadActivityWithData(this.lessonData);
}

class RoundWonEvent extends ActivityEvent {
  final LessonData lessonData;
  RoundWonEvent(this.lessonData);
}

class NextRoundEvent extends ActivityEvent {}
