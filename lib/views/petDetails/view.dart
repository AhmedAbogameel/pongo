import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/core/models/user_model.dart';
import 'package:pet_adoption/core/services/get_user_by_uid.dart';
import 'package:pet_adoption/views/chat/view.dart';
import 'package:pet_adoption/views/petDetails/controller.dart';
import 'package:pet_adoption/views/petDetails/delete_dialog.dart';
import 'package:pet_adoption/views/petDetails/fav_message_buttons.dart';
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
  UserModel _user = UserModel();

  FavouriteController _favouriteController = FavouriteController();
  @override
  void initState() {
    _checkFavourite();
    _getUser();
    super.initState();
  }
  
  void _getUser()async{
    _user = await getUserByUID(widget.petModel.userId);
  }

  void _checkFavourite() async {
    isFavourite = await _favouriteController.checkFavourite(widget.petModel);
    setState(() {});
  }
  UserSingleton _userSingleton = UserSingleton();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PetImage(widget.petModel.photoUrl),
              Spacer(),
              OwnerTile(widget.petModel.userId,widget.petModel.publishAt),
              Text(
                widget.petModel.description,
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.body1,
                textAlign: TextAlign.center,
              ),
              Spacer(),
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: isFavourite.toString() != 'null' ? 1 : 0,
                child: FavMessageButtons(
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
                  removeMessageButton: _userSingleton.userId == widget.petModel.userId,
                  messagePressed: _userSingleton.userId == widget.petModel.userId
                      ? ()=> showDeleteDialog(context,widget.petModel)
                      : ()=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ChatView(_user)))
                  ,
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
          Positioned(top: 18,left: 7,child: PopButton()),
        ],
      ),
    );
  }
}