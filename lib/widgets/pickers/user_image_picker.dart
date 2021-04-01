import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.pickImageFn);

  final void Function(File pickedImage) pickImageFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File?  _image;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage( 
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _image = pickedImageFile;
    });
    widget.pickImageFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 30,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(primary: Theme.of(context).buttonColor),
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add image'),
        )
      ],
    );
  }
}
