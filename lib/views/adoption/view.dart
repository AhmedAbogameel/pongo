import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/home/pet_tile.dart';

class AdoptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: PopButton(
        //   brightness: false,
        // ),
        //elevation: 0.0,
        iconTheme: IconThemeData(color: kAccentColor,size: 30),
        centerTitle: true,
        backgroundColor: kBGColor,
        title: Text(
          'My Adoption List',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(25),
          itemCount: 3,
          itemBuilder: (_, listIndex) => AnimationConfiguration.staggeredList(
            position: listIndex,
            duration: const Duration(seconds: 1),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: PetCard(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
