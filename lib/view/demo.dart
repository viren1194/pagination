// import 'package:flutter/material.dart';

// class DemoPage extends StatefulWidget {
//   const DemoPage({super.key});

//   @override
//   State<DemoPage> createState() => _DemoPageState();
// }

// class _DemoPageState extends State<DemoPage> {
//   int? _currentExpandedTileIndex;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: ListView.builder(
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             return ExpansionTile(
//               onExpansionChanged: (value) {
//                 print(value);
//                 setState(() {
//                   if (value) {
//                     _currentExpandedTileIndex = index;
//                   } else {
//                     _currentExpandedTileIndex = null;
//                   }
//                 });
//               },
//                initiallyExpanded: _currentExpandedTileIndex == index,
//               title: Text(
//                 "hello",
//                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//               ),
//               children: <Widget>[
//                 ListTile(
//                   title: Text(
//                     "Good morninng",
//                     style: TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                 )

//               ],
//             );
//           },
//         ));
//   }
// }
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int? _currentExpandedTileIndex;

  List<String> category1 = ['Abc', 'pqr', 'xyz'];
  List<String> category2 = ['Category 1', 'Category 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildExpansionPanelList('Category 1', category1, 4),
            buildExpansionPanelList('Category 2', category2, 5),
          ],
        ),
      ),
    );
  }

  ExpansionPanelList buildExpansionPanelList(
      String categoryTitle, List<String> category, int itemCount) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _currentExpandedTileIndex =
              _currentExpandedTileIndex == index ? null : index;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: _currentExpandedTileIndex == 0,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                categoryTitle,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
          body: Container(), // You can leave the body empty for the category header
        ),
        ...List.generate(itemCount, (index) {
          return ExpansionPanel(
            isExpanded: _currentExpandedTileIndex == index + 1,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentExpandedTileIndex =
                        _currentExpandedTileIndex == index + 1 ? null : index + 1;
                  });
                },
                child: ListTile(
                  title: Text(
                    "Tile $index",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
            body: ListTile(
              title: Text(
                "Content for Tile $index",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          );
        }),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DemoPage(),
  ));
}
