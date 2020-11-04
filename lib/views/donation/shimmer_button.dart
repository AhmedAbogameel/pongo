import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerButton extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData iconData;
  final bool isBeta;
  ShimmerButton({@required this.onTap,@required this.title,@required this.iconData,this.isBeta = true});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Shimmer.fromColors(
              baseColor: kAccentColor,
              highlightColor: kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(iconData, size: 30,),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onPressed: onTap,
        ),
        if(isBeta)
        Positioned(
          right: 0,
          top: 0,
          child: Banner(
            message: 'Beta',
            location: BannerLocation.topEnd,
            color: kAccentColor,
          ),
        ),
      ],
    );
  }
}