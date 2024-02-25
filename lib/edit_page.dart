import 'package:bookcopilot/chapter_sidebar.dart';
import 'package:side_sheet_material3/side_sheet_material3.dart';
import 'package:bookcopilot/text_field.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

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
    ]
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
              color: const Color.fromARGB(255, 255, 233, 232),
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
                    chapters.add(defaultMap);
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
                  ElevatedButton(onPressed: () {}, child: Text('Continue')),
                  ElevatedButton(onPressed: () {}, child: Text('Complete')),
                  ElevatedButton(onPressed: () {}, child: Text('Other API')),
                  ElevatedButton(
                      onPressed: () async {
                        var displaySentences = [];
                        var paragraphText =
                            chapters[_index][0]['nodes'][1]['textAt'].text;
                        print(paragraphText);
                        RegExp re = new RegExp(r"(\w|\s|,|')+[。.?!]*\s*");

                        // get all the matches:
                        Iterable matches = re.allMatches(paragraphText);

                        //  Iterate all matches:
                        for (Match m in matches) {
                          String? match = m.group(0);
                          print("match: $match");
                          displaySentences.add(match);
                          var request = http.Request(
                              'GET',
                              Uri.parse(
                                  'https://idir.uta.edu/claimbuster/api/v2/query/knowledge_bases/${match}'));
                          request.headers.addAll({
                            "x-api-key": '071f0b216bff4d1cb74922a83381eda9'
                          });

                          var response = await request.send();
                          print('Response status: ${response.statusCode}');
                          print(
                              'Response body: ${await response.stream.bytesToString()}');
                        }

                        showModalSideSheet(
                          context,
                          header: 'Edit Profile',
                          body: Column(
                            children: [
                              for (var x in displaySentences)
                                Row(children: [Text('$x\n')])
                            ],
                          ),
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
                    itemCount: defaultMap[0].length,
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
                                  controller: chapters[_index][0]['nodes']
                                      [index]['textAt'],
                                  focusNode: chapters[_index][0]['nodes'][index]
                                      ['nodeAt'])));
                    })),
          ])),
    ])));
  }
}
