import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/views/menu/menu_frame.dart';
import 'package:pet_adoption/views/petDetails/controller.dart';

void showDeleteDialog(BuildContext context,PetModel petModel){
  showCupertinoDialog(context: context, builder: (_)=> CupertinoAlertDialog(
    title: Text('Warning!'),
    content: Text('This pet will be deleted permanently, would you like to proceed ?'),
    actions: [
      FlatButton(
        child: Text('Delete',style: TextStyle(color: Colors.red),),
        onPressed: ()async{
          showCupertinoDialog(context: context,barrierDismissible: false, builder: (_)=> Center(child: CupertinoActivityIndicator(radius: 50)));
          await FavouriteController().deletePet(petModel);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> MenuFrame()));
        },
      ),
      FlatButton(
        child: Text('Cancel'),
        onPressed: ()=> Navigator.pop(context),
      )
    ],
  ));
}