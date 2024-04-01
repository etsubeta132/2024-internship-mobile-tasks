
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
         title: const Text('My Flutter App'),
         actions: [
            IconButton(
               icon: const Icon(Icons.search),
               onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
               },
            ),
         ],
      ),
   );
}

class DataSearch extends SearchDelegate<String> {
  
   final cities = [
      'City 1',
      'City 2',
      'City 3',
      // Add as many city names as you need
   ];

   final recentCities = [
      'City 1',
      'City 2',
   ];

   
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }


   @override
  Widget buildLeading(BuildContext context) {
    final suggestionList = query.isEmpty
      ? recentCities
      : cities.where((c) => c.startsWith(query)).toList();
      final suggestedCitiesString = suggestionList.join(', ');
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, suggestedCitiesString);
      },
    );
  }
 @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.red,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
      ? recentCities
      : cities.where((c) => c.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: const Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}