import 'package:flutter/material.dart';
import 'package:pet_adoption/widgets/profile_avatar.dart';

import '../../constants.dart';

class OwnerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileAvatar(),
      title: Text('Maya',style: Theme.of(context).textTheme.title,),
      subtitle: Text('Owner',style: Theme.of(context).textTheme.body1,),
      trailing: Padding(
        padding: EdgeInsets.only(right: sizeFromWidth(context, 10)),
        child: Text('May,25,2020',style: Theme.of(context).textTheme.body1,),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: sizeFromWidth(context, 8)),
    );
  }
}
