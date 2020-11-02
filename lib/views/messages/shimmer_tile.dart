import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeFromHeight(context, 6.3),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[200],
                    child: Container(color: Colors.red,),
                  ),
                ),
              ),
              SizedBox(width: 15,),
              SizedBox(
                width: sizeFromHeight(context, 5),
                height: 20.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[200],
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}