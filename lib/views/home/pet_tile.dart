import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/petDetails/view.dart';

class PetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: sizeFromHeight(context, 4),
              width: sizeFromWidth(context, 3),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: kPrimaryColor, blurRadius: 5)],
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: NetworkImage(
                        'https://e7.pngegg.com/pngimages/665/236/png-clipart-cute-dog-puppy-dog.png'),
                    fit: BoxFit.fitHeight),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: sizeFromHeight(context, 5),
                  width: sizeFromWidth(context, 1.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Title',
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text(
                        'Name',
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text(
                        '10 - 15 year',
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: kPrimaryColor, blurRadius: 15)
                      ],
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(25),),),
                ),
                Positioned(
                  right: 15,
                  top: 15,
                  // mars & venus
                  child: Icon(FontAwesomeIcons.venus,color: kAccentColor,size: 35,),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> PetDetailsView(),),);
      },
    );
  }
}
