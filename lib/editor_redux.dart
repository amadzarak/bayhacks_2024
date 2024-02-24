import 'package:bookcopilot/text_field.dart';
import 'package:flutter/material.dart';

enum SmartTextType { H1, T, QUOTE, BULLET }

class TextEditor extends StatelessWidget {
  TextEditor({super.key});

  List<Map> state = [
    {
      'typeAt': SmartTextType.H1,
      'textAt': TextEditingController(),
      'nodeAt': FocusNode(),
    },
    {
      'typeAt': SmartTextType.T,
      'textAt': TextEditingController(),
      'nodeAt': FocusNode(),
    },
  ];

  Map generalMap = {
    'typeAt': SmartTextType.T,
    'textAt': TextEditingController(),
    'nodeAt': FocusNode(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.length,
              itemBuilder: (context, index) {
                return SmartTextField(
                    type: state[index]['typeAt'],
                    controller: state[index]['textAt'],
                    focusNode: state[index]['nodeAt']);
              })),
      Container(
        color: Color.fromARGB(255, 245, 239, 255),
        padding: EdgeInsets.all(10.0),
        child: TextField(
          focusNode: FocusNode(),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.smart_toy),
            hintText: 'Enter Prompt',
          ),
        ),
      ),
    ])));
  }
}
