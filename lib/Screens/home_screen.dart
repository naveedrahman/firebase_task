import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task/Screens/get%20data%20from%20firebase/list%20data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _imageFile;
  File? _pdfFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile != null ? File.fromUri(Uri.file(pickedFile.path)) : null;
    });
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    setState(() {
      _pdfFile = result?.files.single.path != null ? File.fromUri(Uri.file(result!.files.single.path!)) : null;
    });
  }
  TextEditingController _textController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final data = FirebaseFirestore.instance.collection('All_data');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickPdf,
                child: Text('Pick PDF'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle the upload logic here


                  String id= DateTime.now().millisecondsSinceEpoch.toString();
                  data.doc(id).set({
                    'title': _textController.text.toString(),
                    'title': _imageFile.toString(),
                    'title': _pdfFile.toString(),
                    'id':id,


                  }).then((value) => (){

                  }).onError((error, stackTrace) => (){
                    setState(() {

                    });

                  });
                   print('Text: ${_textController.text}');
                  print('Image: $_imageFile');
                  print('PDF: $_pdfFile');
                },
                child: Text('Upload'),
              ),




            ],),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Listdata()),
                );
              },
              child: Text('SHOW DATA'),
            ),
          ],
        ),
      ),
    );
  }
}