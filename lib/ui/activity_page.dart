import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' hide Image;

import '../bloc/activity_bloc.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Page')),
      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          if (state is RoundWon) {
            try {
              context.read<ActivityBloc>().add(NextRoundEvent());
              return Center(child: Rive(artboard: state.artboard));
            } catch (e, stackTrace) {
              debugPrint("❌ Error parsing LessonData: $e");
              debugPrintStack(stackTrace: stackTrace);
            }
          } else if (state is ActivityLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActivityLoaded) {
            if (state.selectedWord != null) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<ActivityBloc>().add(
                        SelectTopicEvent("selected"),
                      );
                    },
                    child: Text(state.selectedWord!),
                  ),
                ],
              );
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<ActivityBloc>().add(
                      SelectTopicEvent("selected"),
                    );
                  },
                  child: const Text("Let's Do"),
                ),
              ],
            );
          } else if (state is TopicSelected) {
            final lesson = state.data;
            final sampleWords =
                lesson.topics.first.scriptTags.first.sampleWords ?? []
                  ..shuffle(Random());

            if (state.isWon == true) {
              context.read<ActivityBloc>().add(RoundWonEvent(state.data));
            } else {}
            return Stack(
              children: [
                Image(
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    state.data.backgroundAssetUrl,
                    scale: 1.3,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.topics.first.topicName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 50,
                    children: sampleWords.map((word) {
                      return TextButton(
                        onPressed: () {
                          context.read<ActivityBloc>().add(
                            WordSelectedEvent(word),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue.shade50,
                          padding: const EdgeInsets.all(50),
                        ),
                        child: Text(word, style: const TextStyle(fontSize: 20)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          } else if (state is ActivityError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
