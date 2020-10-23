import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_adoption/widgets/fav_adoption_buttons.dart';
import 'package:pet_adoption/views/petDetails/owner_tile.dart';
import 'package:pet_adoption/views/petDetails/pet_image.dart';
import 'package:pet_adoption/views/petDetails/pet_info_container.dart';
import 'package:pet_adoption/widgets/pop_button.dart';

class PetDetailsView extends StatefulWidget {
  @override
  _PetDetailsViewState createState() => _PetDetailsViewState();
}

class _PetDetailsViewState extends State<PetDetailsView> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PetImage(),
              Spacer(),
              OwnerTile(),
              Text(
                'My job requires moving to another country',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.body1,
                textAlign: TextAlign.start,
              ),
              Spacer(),
              FavAdoptionButtons(
                favPressed: (){
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                },
                isFavourite: isFavourite,
              ),
            ],
          ),
          PetInfoContainer(),
          PopButton(),
        ],
      ),
    );
  }
}
