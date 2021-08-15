import 'package:flutter/material.dart';
import 'package:midterm/drawer.dart';
import 'package:midterm/model/activity.dart';
import 'package:midterm/page/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:midterm/page/homework.dart';
import 'package:midterm/page/thirdpage.dart';
import 'fixed.dart';
import 'work.dart';
import 'hobbies.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: ActSearch());

              // final results = await
              //     showSearch(context: context, delegate: CitySearch());

              // print('Result: $results');
            },
          )
        ],
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: ValueListenableBuilder<Box<Activity>>(
        valueListenable: Boxes.getActivity().listenable(),
        builder: (context, box, _) {
          final activities = box.values.toList().cast<Activity>();
          return showContent(activities);
        },
      ),
    );
  }

  Widget showContent(List<Activity> activities) {
    if (activities.isEmpty) {
      return Center(
        child: Text(
          'No Data!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Center(
              child: Text(
            'Searching An Activity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.greenAccent.shade700,
            ),
          )),
          SizedBox(height: 24),
        ],
      );
    }
  }
}

class ActSearch extends SearchDelegate<String> {
  final acts = [
    'งานบ้าน',
    'ทำงาน',
    'งานอดิเรก',
    'งานซ่อม',
  ];

  final recentActs = [
    'งานบ้าน',
    'งานอดิเรก',
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 120),
            const SizedBox(height: 48),
            Text(
              query,
              style: TextStyle(
                color: Colors.black,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentActs
        : acts.where((act) {
            final actLower = act.toLowerCase();
            final queryLower = query.toLowerCase();

            return actLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          if (suggestion == 'งานบ้าน') {
            return ListTile(
              onTap: () {
                query = suggestion;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Homeworkpage(),
                  ),
                );

                // 1. Show Results

                // 2. Close Search & Return Result
                // close(context, suggestion);

                // 3. Navigate to Result Page
                /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Thirdpage(),
                ),
              );*/
              },
              leading: Icon(Icons.location_city),
              // title: Text(suggestion),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: remainingText,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (suggestion == 'งานซ่อม') {
            return ListTile(
              onTap: () {
                query = suggestion;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Fixedpage(),
                  ),
                );

                // 1. Show Results

                // 2. Close Search & Return Result
                // close(context, suggestion);

                // 3. Navigate to Result Page
                /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Thirdpage(),
                ),
              );*/
              },
              leading: Icon(Icons.location_city),
              // title: Text(suggestion),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: remainingText,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (suggestion == 'ทำงาน') {
            return ListTile(
              onTap: () {
                query = suggestion;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Workpage(),
                  ),
                );

                // 1. Show Results

                // 2. Close Search & Return Result
                // close(context, suggestion);

                // 3. Navigate to Result Page
                /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Thirdpage(),
                ),
              );*/
              },
              leading: Icon(Icons.location_city),
              // title: Text(suggestion),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: remainingText,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (suggestion == 'งานอดิเรก') {
            return ListTile(
              onTap: () {
                query = suggestion;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Hobbiespage(),
                  ),
                );

                // 1. Show Results

                // 2. Close Search & Return Result
                // close(context, suggestion);

                // 3. Navigate to Result Page
                /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Thirdpage(),
                ),
              );*/
              },
              leading: Icon(Icons.location_city),
              // title: Text(suggestion),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: remainingText,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ListTile(
              onTap: () {
                query = suggestion;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Thirdpage(),
                  ),
                );

                // 1. Show Results

                // 2. Close Search & Return Result
                // close(context, suggestion);

                // 3. Navigate to Result Page
                /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Thirdpage(),
                ),
              );*/
              },
              leading: Icon(Icons.location_city),
              // title: Text(suggestion),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: remainingText,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
}
