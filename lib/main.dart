import 'package:bookcopilot/editor_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String notes = '';

  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    descriptionController.addListener(() {
      print(descriptionController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        NavigationHeader(),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      color: Color.fromRGBO(230, 232, 235, 1), width: 1),
                  bottom: BorderSide(
                      color: Color.fromRGBO(230, 232, 235, 1), width: 1),
                  left: BorderSide(
                      color: Color.fromRGBO(230, 232, 235, 1), width: 1),
                  right: BorderSide(
                      color: Color.fromRGBO(230, 232, 235, 1), width: 1)),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              shape: BoxShape.rectangle,
            ),
            child: MarkdownTextInput(
              (String value) => setState(() => notes = value),
              notes,
              label: 'Description',
              maxLines: 10,
              actions: MarkdownType.values,
              controller: descriptionController,
              textStyle: const TextStyle(fontSize: 16),
            )),
        Row(children: [
          Text('Featured Publications', style: TextStyle(fontSize: 20)),
        ]),
        BookCarouselWidget(title: 'Test')
      ]),
    ));
  }
}

class NavigationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: () {}, child: Text('Login')),
        TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TextEditor()));
            },
            child: Text('Author')),
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
      ],
    ));
  }
}

class BookCarouselWidget extends StatelessWidget {
  String title;

  String? imageURL;

  BookCarouselWidget({super.key, required this.title, this.imageURL});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: 155,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(alignment: Alignment.center, children: [
            Text(title),
            (imageURL != null)
                ? Image.network(
                    imageURL!,
                    fit: BoxFit.fill,
                  )
                : Container(),
          ]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ));
  }
}
