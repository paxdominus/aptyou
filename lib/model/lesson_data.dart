import 'topic.dart';

class LessonData {
  final String lessonId;
  final String lessonName;
  final String lessonDescription;
  final String learnFormat;
  final List<String> topicOutcome;
  final String backgroundAssetUrl;
  final List<Topic> topics;

  LessonData({
    required this.lessonId,
    required this.lessonName,
    required this.lessonDescription,
    required this.learnFormat,
    required this.topicOutcome,
    required this.backgroundAssetUrl,
    required this.topics,
  });

  factory LessonData.fromJson(Map<String, dynamic> json) {
    return LessonData(
      lessonId: json['lessonId'],
      lessonName: json['lessonName'],
      lessonDescription: json['lessonDescription'],
      learnFormat: json['learnFormat'],
      topicOutcome: List<String>.from(json['topicOutcome']),
      backgroundAssetUrl: json['backgroundAssetUrl'],
      topics: (json['topics'] as List).map((e) => Topic.fromJson(e)).toList(),
    );
  }
}
