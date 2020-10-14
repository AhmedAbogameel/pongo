import 'package:flutter/material.dart';
import 'package:pet_adoption/widgets/profile_avatar.dart';

import '../../constants.dart';

class OwnerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileAvatar(),
      // ignore: deprecated_member_use
      title: Text('Maya',style: Theme.of(context).textTheme.title,),
      // ignore: deprecated_member_use
      subtitle: Text('Owner',style: Theme.of(context).textTheme.body1,),
      trailing: Padding(
        padding: EdgeInsets.only(right: sizeFromWidth(context, 10)),
        // ignore: deprecated_member_use
        child: Text('May,25,2020',style: Theme.of(context).textTheme.body1,),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: sizeFromWidth(context, 8)),
    );
  }
}
