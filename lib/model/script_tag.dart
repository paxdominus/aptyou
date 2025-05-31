class ScriptTag {
  final int id;
  final String format;
  final String? gameType;
  final String? gameIntroAudio;
  final List<String>? taskAudioCapitalLetter;
  final List<String>? taskAudioSmallLetter;
  final List<String>? correctCapitalAudios;
  final List<String>? correctSmallAudios;
  final String? superstarAudio;
  final List<String>? tapWrongAudio;
  final List<String>? roundPrompts;
  final String? finishGameAudio;
  final String? cardRewardRive;
  final String? finalCelebrationRive;
  final List<String>? sampleWords;
  final String? buttonText;

  ScriptTag({
    required this.id,
    required this.format,
    this.gameType,
    this.gameIntroAudio,
    this.taskAudioCapitalLetter,
    this.taskAudioSmallLetter,
    this.correctCapitalAudios,
    this.correctSmallAudios,
    this.superstarAudio,
    this.tapWrongAudio,
    this.roundPrompts,
    this.finishGameAudio,
    this.cardRewardRive,
    this.finalCelebrationRive,
    this.sampleWords,
    this.buttonText,
  });

  factory ScriptTag.fromJson(Map<String, dynamic> json) {
    return ScriptTag(
      id: json['id'] ?? 0,
      format: json['format'] ?? '',
      gameType: json['gameType'],
      gameIntroAudio: json['gameIntroAudio'],
      taskAudioCapitalLetter: (json['taskAudioCapitalLetter'] as List?)
          ?.cast<String>(),
      taskAudioSmallLetter: (json['taskAudioSmallLetter'] as List?)
          ?.cast<String>(),
      correctCapitalAudios: (json['correctCapitalAudios'] as List?)
          ?.cast<String>(),
      correctSmallAudios: (json['correctSmallAudios'] as List?)?.cast<String>(),
      superstarAudio: json['superstarAudio'],
      tapWrongAudio: (json['tapWrongAudio'] as List?)?.cast<String>(),
      roundPrompts: (json['roundPrompts'] as List?)?.cast<String>(),
      finishGameAudio: json['finishGameAudio'],
      cardRewardRive: json['cardRewardRive'],
      finalCelebrationRive: json['finalCelebrationRive'],
      sampleWords: (json['sampleWords'] as List?)?.cast<String>(),
      buttonText: json['buttonText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'format': format,
      'gameType': gameType,
      'gameIntroAudio': gameIntroAudio,
      'taskAudioCapitalLetter': taskAudioCapitalLetter,
      'taskAudioSmallLetter': taskAudioSmallLetter,
      'correctCapitalAudios': correctCapitalAudios,
      'correctSmallAudios': correctSmallAudios,
      'superstarAudio': superstarAudio,
      'tapWrongAudio': tapWrongAudio,
      'roundPrompts': roundPrompts,
      'finishGameAudio': finishGameAudio,
      'cardRewardRive': cardRewardRive,
      'finalCelebrationRive': finalCelebrationRive,
      'sampleWords': sampleWords,
      'buttonText': buttonText,
    };
  }
}
