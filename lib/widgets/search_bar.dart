import 'package:flutter/material.dart';
import 'package:wilson_tours_app/utils/color.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> _data = [
    'apple',
    'banana',
    'cherry',
    'date',
    'elderberry',
    'fig',
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: kPrimaryColor,
      primaryColor: Colors.green[400],
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text('Results for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? _data
        : _data
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            suggestionList[index],
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }

}
