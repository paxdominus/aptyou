import 'script_tag.dart';

class Topic {
  final String topicId;
  final String topicName;
  final List<ScriptTag> scriptTags;
  final List<String> sampleWords;
  final String buttonText;
  final String superstarAudio;
  final String finishGameAudio;
  final String cardRewardRive;
  final String finalCelebrationRive;
  final List<String> tapWrongAudio;
  final List<String> roundPrompts;

  Topic({
    required this.topicId,
    required this.topicName,
    required this.scriptTags,
    required this.sampleWords,
    required this.buttonText,
    required this.superstarAudio,
    required this.finishGameAudio,
    required this.cardRewardRive,
    required this.finalCelebrationRive,
    required this.tapWrongAudio,
    required this.roundPrompts,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: json['topicId'],
      topicName: json['topicName'],
      scriptTags: (json['scriptTags'] as List)
          .map((e) => ScriptTag.fromJson(e))
          .toList(),
      sampleWords: List<String>.from(json['sampleWords'] ?? []),
      buttonText: json['buttonText'] ?? '',
      superstarAudio: json['superstarAudio'] ?? '',
      finishGameAudio: json['finishGameAudio'] ?? '',
      cardRewardRive: json['cardRewardRive'] ?? '',
      finalCelebrationRive: json['finalCelebrationRive'] ?? '',
      tapWrongAudio: List<String>.from(json['tapWrongAudio'] ?? []),
      roundPrompts: List<String>.from(json['roundPrompts'] ?? []),
    );
  }
}
