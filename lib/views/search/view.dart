import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/views/search/controller.dart';
import 'package:pet_adoption/widgets/animated_list_view.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import '../../constants.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<PetModel> allPets = SearchController().allPets;
  List<PetModel> searchedPets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kAccentColor),
        backgroundColor: kBGColor,
        // ignore: deprecated_member_use
        title: Text('Search by Name',style: Theme.of(context).textTheme.subtitle,),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: inputField(
                hint: 'EX : Pongo',
                icon: FontAwesomeIcons.search,
                onChanged: (String value){
                  hideStatusBar();
                  searchedPets.clear();
                  allPets.forEach((element) {
                    if(element.toJson()['petName'].contains(value)){
                      setState(() {
                        searchedPets.add(element);
                      });
                    }
                  });
                  if(value.isEmpty){
                    setState(() {
                      searchedPets.clear();
                    });
                  }
                }
            ),
          ),
          Expanded(child: searchedPets.isEmpty ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off_rounded,color: kAccentColor.withOpacity(0.7),size: sizeFromHeight(context, 5),),
              // ignore: deprecated_member_use
              Text('No Result',style: Theme.of(context).textTheme.subtitle,),
            ],
          ) : AnimatedListView(items: searchedPets)),
        ],
      ),
    );
  }
}