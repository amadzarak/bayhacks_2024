import 'package:bookcopilot/text_field.dart';
import 'package:flutter/material.dart';

typedef void onAdd(int idx);

typedef void switchChapter(int index);

class ChapterSidebar extends StatefulWidget {
  List chapters;

  switchChapter? onSwitch;

  final onAdd;
  ChapterSidebar({Key? key, required this.chapters, this.onSwitch, this.onAdd})
      : super(key: key);

  @override
  State<ChapterSidebar> createState() => _ChapterSidebarState();
}

class _ChapterSidebarState extends State<ChapterSidebar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [
              Text('Outline',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.chapters.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: (widget.chapters[index][0]['nodes'][0]['textAt'].text ==
                        '')
                    ? Text('Untitled Chapter')
                    : Text(widget.chapters[index][0]['nodes'][0]['textAt'].text
                        .toString()),
                onTap: () {
                  widget.onSwitch!(index);
                },
              );
            },
          )),
          Row(children: [
            Expanded(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                      child: Text('+ Add Chapter'), onPressed: widget.onAdd)),
            ),
          ]),
        ]));
  }
}
