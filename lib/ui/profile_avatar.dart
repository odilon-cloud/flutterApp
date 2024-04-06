import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _image;

  Future getImage() async {
    final picker = ImagePicker();
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: Text('Camera'),
          ),
        ],
      ),
    );

    if (source != null) {
      final pickedFile = await picker.pickImage(
        source: source,
      );

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          // TODO: Upload _image as the new profile picture
        } else {
          print('No image selected.');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getImage,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _image != null ? FileImage(_image!) : null,
        child: _image == null ? Icon(Icons.person) : null,
      ),
    );
  }
}

