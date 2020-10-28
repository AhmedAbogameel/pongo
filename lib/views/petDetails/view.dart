import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/views/petDetails/controller.dart';
import 'package:pet_adoption/widgets/fav_adoption_buttons.dart';
import 'package:pet_adoption/views/petDetails/owner_tile.dart';
import 'package:pet_adoption/views/petDetails/pet_image.dart';
import 'package:pet_adoption/views/petDetails/pet_info_container.dart';
import 'package:pet_adoption/widgets/pop_button.dart';

class PetDetailsView extends StatefulWidget {
  final PetModel petModel;
  PetDetailsView(this.petModel);
  @override
  _PetDetailsViewState createState() => _PetDetailsViewState();
}

class _PetDetailsViewState extends State<PetDetailsView> {
  bool isFavourite;

  FavouriteController _favouriteController = FavouriteController();
  @override
  void initState() {
    _checkFavourite();
    super.initState();
  }

  void _checkFavourite() async {
    isFavourite = await _favouriteController.checkFavourite(widget.petModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PetImage(widget.petModel.photoUrl),
              Spacer(),
              OwnerTile(widget.petModel.userId),
              Text(
                widget.petModel.description,
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.body1,
                textAlign: TextAlign.start,
              ),
              Spacer(),
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: isFavourite.toString() != 'null' ? 1 : 0,
                child: FavAdoptionButtons(
                  favPressed: () async {
                    isFavourite
                        ? await _favouriteController
                            .removeFavourite(widget.petModel)
                        : await _favouriteController
                            .addFavourite(widget.petModel);
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  isFavourite: isFavourite,
                ),
              ),
            ],
          ),
          PetInfoContainer(
            age: widget.petModel.age,
            isMale: widget.petModel.isMale,
            kind: widget.petModel.kind,
            petName: widget.petModel.petName,
          ),
          PopButton(),
        ],
      ),
    );
  }
}
