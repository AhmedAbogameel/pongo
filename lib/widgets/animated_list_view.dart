import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/widgets/pet_tile.dart';

class AnimatedListView extends StatelessWidget {
  final List<PetModel> items;
  AnimatedListView({this.items});
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, listIndex) => AnimationConfiguration.staggeredList(
          position: listIndex,
          duration: const Duration(seconds: 1),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: PetCard(items[listIndex]),
            ),
          ),
        ),
      ),
    );
  }
}