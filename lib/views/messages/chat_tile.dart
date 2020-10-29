import 'package:flutter/material.dart';
import 'package:pet_adoption/views/chat/view.dart';
import '../../constants.dart';

class ChatTile extends StatelessWidget {
  final String photoUrl;
  final String name;
  ChatTile({this.photoUrl, this.name});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (_){},
      key: ValueKey('a'),
      child: InkWell(
        splashColor: kAccentColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        child: Card(
          color: kBGColor,
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child: Row(
              children: [
                Hero(
                  tag: '0',
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://alkhabaralyemeni.net/wp-content/uploads/2020/03/image-2-1.jpg'),
                  ),
                ),
                SizedBox(width: 15,),
                Flexible(child: Text('Ahmed Abogameel',softWrap: false,overflow: TextOverflow.fade,style: textTheme.title.copyWith(fontSize: 20),))
              ],),
          ),
        ),
        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatView())),
      ),
    );
  }
}