import 'package:bookcopilot/text_field.dart';
import 'package:flutter/material.dart';

typedef void onAdd(List prompt);

List<Map> chapterList = [
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

class PromptHistory extends StatefulWidget {
  final onAdd;
  PromptHistory({Key? key, this.onAdd}) : super(key: key);

  @override
  State<PromptHistory> createState() => _PromptHistoryState();
}

class _PromptHistoryState extends State<PromptHistory> {
  List promptHistory = ['Chapter 1', 'Chapter 2', 'Chapter 3'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    promptHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView.builder(
        shrinkWrap: true,
        itemCount: promptHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(promptHistory[index][0]['Title']),
            onTap: () {},
          );
        },
      )),
      Row(children: [
        Expanded(
          child: Container(
              color: Color.fromARGB(255, 245, 239, 255),
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                  child: Text('+ Add Chapter'),
                  onPressed: () {
                    widget.onAdd(chapterList);
                    setState(() {
                      promptHistory.add('Chapter ${promptHistory.length + 1}');
                    });
                  })),
        ),
      ]),
    ]);
  }
}
