import 'package:bookcopilot/chapter_sidebar.dart';

import 'package:bookcopilot/text_field.dart';
import 'package:flutter/material.dart';

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
                  setState(() {
                    _index = index;
                  });
                },
                onAdd: () {
                  setState(() {
                    chapters.add(defaultMap);
                  });
                },
              ))),
      Expanded(
          flex: 3,
          child: Column(children: [
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: chapters.length - 1,
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
