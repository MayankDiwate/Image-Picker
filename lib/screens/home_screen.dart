import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_app/widgets/drag_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlatformFile? platformFile;
  Future selectFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      platformFile = result.files.first;
    });
    platformFile != null
        ? ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Image Uploaded !')))
        : null;
    return result;
  }

  bool isAccepted = false;
  Color color = Colors.green;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.04),
            ElevatedButton.icon(
              onPressed: () => selectFile(context),
              label: const Text('Upload Image'),
              icon: const Icon(Icons.upload),
            ),
            SizedBox(height: size.height * 0.05),
            DragWidget(platformFile: platformFile, isCompleted: isAccepted),
            SizedBox(height: size.height * 0.05),
            DragTarget<PlatformFile>(
              onAccept: (data) => setState(() {
                platformFile = data;
                setState(() {
                  isAccepted = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Image Pasted !')));
              }),
              builder: (ctx, _, __) {
                return isAccepted
                    ? Expanded(
                        child: SizedBox(
                          height: size.height * 0.3,
                          width: size.height * 0.3,
                          child: Image.file(
                            File(platformFile!.path!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        height: size.height * 0.3,
                        width: size.height * 0.3,
                        color: Colors.green,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
