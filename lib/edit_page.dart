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

  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //appBar: AppBar(automaticallyImplyLeading: true),
        body: SafeArea(
            child: Row(children: [
          Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        right: BorderSide(
                            color: Color.fromRGBO(236, 238, 240, 1), width: 1)),
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
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Set the button shape
                            ),
                          ),
                          onPressed: () async {
                            showModalSideSheet(
                              context,
                              header: 'Extend my Text',
                              body: FutureBuilder(
                                  future: extendChapterRequest(chapters[_index]
                                          [0]['nodes'][1]['textAt']
                                      .text),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return ListView.builder(
                                          itemCount: 2,
                                          itemBuilder: ((context, index) {
                                            if (snapshot.data != null) {
                                              print(snapshot.data);

                                              var response =
                                                  jsonDecode(snapshot.data);
                                              return GestureDetector(
                                                  onTap: () {
                                                    chapters[_index][0]['nodes']
                                                        .add({
                                                      'typeAt': SmartTextType.T,
                                                      'textAt':
                                                          TextEditingController(),
                                                      'nodeAt': FocusNode(),
                                                    });

                                                    chapters[_index][0]['nodes']
                                                            .last['textAt']
                                                            .text =
                                                        response['context']
                                                            ['opt${index + 1}'];

                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      child: Column(children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                            'Option ${index + 1}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15))
                                                      ],
                                                    ),
                                                    Row(children: [
                                                      Text(response['context'][
                                                              'opt${index + 1}']
                                                          .toString())
                                                    ])
                                                  ])));
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
                          child: Text('I\'m Stuck')),
                      SizedBox(width: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Set the button shape
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Continue')),
                      SizedBox(width: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Set the button shape
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Other API')),
                      SizedBox(width: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Set the button shape
                            ),
                          ),
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
                                              Map valueMap = jsonDecode(
                                                  snapshot.data[index]);

                                              print(valueMap.keys.toString());
                                              print(valueMap);
                                              return ListTile(
                                                title: Text(valueMap['claim']
                                                    .toString()),
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
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: chapters[_index][0]['nodes'].length,
                      itemBuilder: (context, index) {
                        return Container(
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
                                    ['nodeAt']));
                      }),
                ),
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: Color.fromRGBO(236, 234, 240, 1))),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Wrap(
                        children: [
                          TextButton(onPressed: () {}, child: Text('H2')),
                          SizedBox(
                            height: 30,
                            child: VerticalDivider(
                                width: 20,
                                thickness: 1,
                                color: Color.fromRGBO(236, 238, 240, 1)),
                          ),
                          TextButton(
                              onPressed: () {}, child: Text('Paragraph')),
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

Future extendChapterRequest(String paragraphText) async {
  final String url = "http://34.224.173.78:8080/extend_chapter";

  Map<String, dynamic> req_body = {"context": paragraphText};

  try {
    String requestBodyJson = json.encode(req_body);

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: requestBodyJson);

    if (response.statusCode == 200) {
      return response.body;
    }
  } catch (e) {
    print(e);
  }

  return [];
}
