import 'dart:ui';

import 'package:flutter/material.dart';

class CreatePubInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final String label;
  final String helper;
  final TextAlign align;
  final Widget prefix;

  CreatePubInput({
    Key key,
    this.controller,
    this.type,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.label,
    this.helper,
    this.align,
    this.prefix,
  }) : super(key: key);

  @override
  _CreatePubInputState createState() => _CreatePubInputState();
}

class _CreatePubInputState extends State<CreatePubInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.type,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        textAlign: widget.align ?? TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 17.5,
        ),
        decoration: InputDecoration(
          prefix: widget.prefix,
          labelText: widget.label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 17.5,
          ),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          helperText: widget.helper,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
