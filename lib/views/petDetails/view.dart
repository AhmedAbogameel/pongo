import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/petDetails/owner_tile.dart';
import 'package:pet_adoption/views/petDetails/pet_info_container.dart';
import 'package:pet_adoption/widgets/pop_button.dart';

class PetDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: sizeFromHeight(context, 2, removeAppBarSize: false),
                color: kPrimaryColor,
                child: Hero(
                  tag: '1',
                  child: Image.network(
                      'https://e7.pngegg.com/pngimages/665/236/png-clipart-cute-dog-puppy-dog.png'),
                ),
                alignment: Alignment.center,
              ),
              Spacer(),
              OwnerTile(),
              Text(
                'My job requires moving to another country',
                style: Theme.of(context).textTheme.body1,
                textAlign: TextAlign.start,
              ),
              Spacer(),
              Container(
                height: sizeFromHeight(context, 7),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(35))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        colorBrightness: Brightness.dark,
                        child: Icon(
                          Icons.favorite_border,
                          //color: kBGColor,
                        ),
                        color: kAccentColor,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: sizeFromWidth(context, 2),
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        colorBrightness: Brightness.dark,
                        child: Text('Adoption',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        color: kAccentColor,
                      ),
                    ),
                  ],
                ),
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
