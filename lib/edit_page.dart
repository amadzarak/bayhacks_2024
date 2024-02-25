import 'package:bookcopilot/chapter_sidebar.dart';
import 'package:side_sheet_material3/side_sheet_material3.dart';
import 'package:bookcopilot/text_field.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

var url = Uri.https('example.com', 'whatsit/create');

Random rnd = Random();

class TextEditor extends StatefulWidget {
  TextEditor({super.key});

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  List<List<Map>> chapters = [
    [
      {
        'title': 'Chapter Title',
        'nodes': [
          {
            'typeAt': SmartTextType.H1,
            'textAt': TextEditingController(),
            'nodeAt': FocusNode(),
          },
          {
            'typeAt': SmartTextType.T,
            'textAt': TextEditingController(),
            'nodeAt': FocusNode(),
          }
        ],
      }
    ],
  ];
  List<Map<dynamic, dynamic>> defaultMap = [
    {
      'key': rnd,
      'nodes': [
        {
          'typeAt': SmartTextType.H1,
          'textAt': TextEditingController(),
          'nodeAt': FocusNode(),
        },
        {
          'typeAt': SmartTextType.T,
          'textAt': TextEditingController(),
          'nodeAt': FocusNode(),
        }
      ],
    }
  ];

  Map generalMap = {
    'typeAt': SmartTextType.T,
    'textAt': TextEditingController(),
    'nodeAt': FocusNode(),
  };

  Color _hoverColor = Colors.white;

  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hoverColor;
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(automaticallyImplyLeading: true),
        body: SafeArea(
            child: Row(children: [
      Expanded(
          flex: 1,
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 245, 245),
                border:
                    Border(right: BorderSide(color: Colors.black, width: 1)),
              ),
              child: ChapterSidebar(
                chapters: chapters,
                onSwitch: (index) {
                  print(index);
                  setState(() {
                    _index = index;
                  });
                },
                onAdd: () {
                  print(chapters);
                  setState(() {
                    chapters.add([
                      {
                        'chapter_number': chapters.length + 1,
                        'nodes': [
                          {
                            'typeAt': SmartTextType.H1,
                            'textAt': TextEditingController(),
                            'nodeAt': FocusNode(),
                          },
                          {
                            'typeAt': SmartTextType.T,
                            'textAt': TextEditingController(),
                            'nodeAt': FocusNode(),
                          }
                        ],
                      }
                    ]);
                  });
                },
              ))),
      Expanded(
          flex: 3,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('I\'m Stuck')),
                  ElevatedButton(onPressed: () {}, child: Text('Continue')),
                  ElevatedButton(onPressed: () {}, child: Text('Other API')),
                  ElevatedButton(
                      onPressed: () async {
                        showModalSideSheet(
                          context,
                          header: 'Fact Check My Document',
                          body: FutureBuilder(
                              future: factCheckRequest(chapters[_index][0]
                                      ['nodes'][1]['textAt']
                                  .text),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: ((context, index) {
                                        if (snapshot.data != null) {
                                          print(snapshot.data);
                                          Map valueMap =
                                              jsonDecode(snapshot.data[index]);

                                          print(valueMap.keys.toString());
                                          print(valueMap);
                                          return ListTile(
                                            title: Text(
                                                valueMap['claim'].toString()),
                                            subtitle: Text(
                                                valueMap['justification'][0]
                                                        ['truth_rating']
                                                    .toString()),
                                          );
                                        }
                                      }));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                          addBackIconButton: true,
                          addActions: true,
                          addDivider: true,
                          confirmActionTitle: 'Save',
                          cancelActionTitle: 'Cancel',
                          confirmActionOnPressed: () {},

                          // If null, Navigator.pop(context) will used
                          cancelActionOnPressed: () {
                            // Do something
                          },
                          transitionDuration: Duration(milliseconds: 100),
                        );
                      },
                      child: Text('Fact Check'))
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: chapters[_index][0]['nodes'].length,
                itemBuilder: (context, index) {
                  return MouseRegion(
                      onHover: (event) {
                        setState(() {
                          _hoverColor =
                              const Color.fromARGB(255, 251, 255, 255);
                        });
                      },
                      child: Container(
                          color: _hoverColor,
                          child: SmartTextField(
                              type: chapters[_index][0]['nodes'][index]
                                  ['typeAt'],
                              onAction: () {
                                print(chapters[_index][0]['nodes']);

                                setState(() {
                                  chapters[_index][0]['nodes'].add({
                                    'typeAt': SmartTextType.T,
                                    'textAt': TextEditingController(),
                                    'nodeAt': FocusNode(),
                                  });
                                });
                                print(chapters[_index][0]['nodes']);
                              },
                              controller: chapters[_index][0]['nodes'][index]
                                  ['textAt'],
                              focusNode: chapters[_index][0]['nodes'][index]
                                  ['nodeAt'])));
                }),
            Center(
                child: Card(
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Wrap(
                    children: [
                      Text('H2'),
                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                            width: 20, thickness: 1, color: Colors.black),
                      ),
                      Text('Paragraph')
                    ],
                  )),
            ))
          ])),
    ])));
  }
}

Future factCheckRequest(String paragraphText) async {
  var displaySentences = [];

  print(paragraphText);
  RegExp re = new RegExp(r"(\w|\s|,|')+[。.?!]*\s*");

  // get all the matches:
  Iterable matches = re.allMatches(paragraphText);

  List APIResponse = [];
  //  Iterate all matches:
  for (Match m in matches) {
    String? match = m.group(0);
    print("match: $match");
    displaySentences.add(match);
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://idir.uta.edu/claimbuster/api/v2/query/knowledge_bases/${match}'));
    request.headers.addAll({"x-api-key": '071f0b216bff4d1cb74922a83381eda9'});

    var response = await request.send();

    APIResponse.add(await response.stream.bytesToString());
  }

  return APIResponse;
}
