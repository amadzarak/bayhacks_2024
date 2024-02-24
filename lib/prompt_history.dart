import 'package:flutter/material.dart';

class PromptHistory extends StatelessWidget {
  PromptHistory({Key? key}) : super(key: key);

  List promptHistory = ['Prompt 1', 'Prompt 2', 'Prompt 3'];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(title: Text(promptHistory[index])),
          );
        },
      )),
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
    ]);
  }
}
