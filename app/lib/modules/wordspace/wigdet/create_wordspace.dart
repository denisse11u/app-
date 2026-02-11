import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateWordspace extends StatefulWidget {
  const CreateWordspace({super.key});

  @override
  State<CreateWordspace> createState() => _CreateWordspaceState();
}

class _CreateWordspaceState extends State<CreateWordspace> {
  File? image;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("nuevo texto")),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,

                children: [
                  CircleAvatar(
                    radius: 50,

                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null ? Icon(Icons.person, size: 40) : null,
                    // backgroundImage: NetworkImage(
                    //   'https://marketplace.canva.com/A5alg/MAESXCA5alg/1/tl/canva-user-icon-MAESXCA5alg.png',
                    // ),
                    // child: Text(
                    //
                    //   style: TextStyle(fontSize: 40, color: Colors.white),
                    // ),
                  ),

                  // TextButton.icon(
                  //   onPressed: pickImage,
                  //   label: Icon(Icons.add_a_photo_rounded),
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickImage,

                      // child: Container(
                      //   padding: EdgeInsets.all(6),
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     shape: BoxShape.circle,
                      //   ),
                      child: Container(
                        // color: Colors.amberAccent,
                        child: Icon(Icons.add_a_photo_rounded, size: 20),
                      ),
                    ),
                  ),
                ],
              ),

              // TextButton(onPressed: pickImage, child: Text('data')),
              SizedBox(height: 24),

              TextField(decoration: InputDecoration(hintText: "Título")),
              SizedBox(height: 24),

              TextField(decoration: InputDecoration(hintText: "Correo")),
              SizedBox(height: 24),

              TextField(decoration: InputDecoration(hintText: "URL")),
              SizedBox(height: 24),

              TextField(decoration: InputDecoration(hintText: "Password")),

              SizedBox(height: 24),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(hintText: "Nota"),
              ),
              SizedBox(height: 24),

              FloatingActionButton(onPressed: () => context),
              Icon(Icons.abc_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
