import 'package:bookcopilot/prompt_history.dart';
import 'package:bookcopilot/text_field.dart';
import 'package:flutter/material.dart';

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
        //appBar: AppBar(automaticallyImplyLeading: true),
        body: SafeArea(
            child: Row(children: [
      Expanded(
          flex: 1,
          child: Container(
              color: const Color.fromARGB(255, 255, 233, 232),
              child: PromptHistory())),
      Expanded(
          flex: 3,
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
          ])),
    ])));
  }
}
