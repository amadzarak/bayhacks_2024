import 'package:flutter/material.dart';

enum SmartTextType { H1, T, QUOTE, BULLET, BREAK }

typedef void SmartTextInputAction();

class SmartTextField extends StatelessWidget {
  SmartTextField(
      {Key? key,
      required this.type,
      required this.controller,
      required this.focusNode,
      this.onAction})
      : super(key: key);

  final SmartTextType type;
  final TextEditingController controller;
  final FocusNode focusNode;
  final SmartTextInputAction? onAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
        onSubmitted: (value) {
          onAction!();
        },
        textInputAction: TextInputAction.search,
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        cursorColor: Colors.teal,
        textAlign: type.align,
        decoration: InputDecoration(
            hintText: (type) {
              switch (type) {
                case SmartTextType.H1:
                  return 'Heading 1';
                  break;
                case SmartTextType.QUOTE:
                  return 'Quote';
                  break;
                case SmartTextType.BULLET:
                  return 'Bullet';
                  break;
                case SmartTextType.BREAK:
                  return '';
                  break;
                default:
                  return 'Paragraph';
              }
            }(type),
            border: InputBorder.none,
            prefixText: type.prefix,
            prefixStyle: type.textStyle,
            isDense: true,
            contentPadding: type.padding),
        style: type.textStyle);
  }
}

extension SmartTextStyle on SmartTextType {
  TextStyle get textStyle {
    switch (this) {
      case SmartTextType.QUOTE:
        return TextStyle(
            fontSize: 16.0, fontStyle: FontStyle.italic, color: Colors.white70);
      case SmartTextType.H1:
        return TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
        break;
      default:
        return TextStyle(fontSize: 16.0);
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case SmartTextType.H1:
        return EdgeInsets.fromLTRB(16, 24, 16, 8);
        break;
      case SmartTextType.QUOTE:
        return EdgeInsets.fromLTRB(16, 16, 16, 16);
      case SmartTextType.BULLET:
        return EdgeInsets.fromLTRB(24, 8, 16, 8);
      default:
        return EdgeInsets.fromLTRB(16, 8, 16, 8);
    }
  }

  TextAlign get align {
    switch (this) {
      case SmartTextType.QUOTE:
        return TextAlign.center;
        break;
      default:
        return TextAlign.start;
    }
  }

  String? get prefix {
    switch (this) {
      case SmartTextType.BULLET:
        return '\u2022 ';
        break;
      default:
    }
  }
}
