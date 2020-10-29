import 'package:flutter/material.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';

import '../../constants.dart';

class FavAdoptionButtons extends StatelessWidget {
  final bool isFavourite;
  final Function favPressed;
  FavAdoptionButtons({this.isFavourite, this.favPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(context, 7),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: sizeFromHeight(context, 13),
            child: Builder(
              builder: (ctx) => RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                colorBrightness: Brightness.dark,
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  //color: kBGColor,
                ),
                color: kAccentColor,
                onPressed: () {
                  favPressed();
                  showSnackBar(
                    ctx,
                    title: !isFavourite
                        ? 'Added to favourites'
                        : 'Removed from favourites',
                    onPressed: favPressed,
                  );
                },
              ),
            ),
          ),
          Container(
            height: sizeFromHeight(context, 13),
            width: sizeFromWidth(context, 2),
            child: RaisedButton(
              onPressed: (){},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              colorBrightness: Brightness.dark,
              child: Text(
                'Message Owner',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              color: kAccentColor,
            ),
          ),
        ],
      ),
    );
  }
}
