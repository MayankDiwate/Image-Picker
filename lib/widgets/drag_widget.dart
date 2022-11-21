import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DragWidget extends StatefulWidget {
  DragWidget(
      {super.key, required this.platformFile, required this.isCompleted});

  final PlatformFile? platformFile;
  bool isCompleted;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Draggable<PlatformFile>(
      maxSimultaneousDrags: widget.isCompleted ? 0 : 1,
      onDragCompleted: () {
        setState(() {
          widget.isCompleted = true;
        });
      },
      onDragStarted: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Image Copied !')));
      },
      data: widget.platformFile,
      feedback: showImage(context),
      childWhenDragging: Container(
        height: size.height * 0.3,
        width: size.height * 0.3,
        color: Colors.red,
      ),
      child: showImage(context),
    );
  }

  Widget showImage(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.platformFile == null || widget.isCompleted
        ? Container(
            height: size.height * 0.3,
            width: size.height * 0.3,
            color: Colors.red,
          )
        : Expanded(
            child: SizedBox(
              height: size.height * 0.3,
              width: size.height * 0.3,
              child: Image.file(
                File(widget.platformFile!.path!),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
