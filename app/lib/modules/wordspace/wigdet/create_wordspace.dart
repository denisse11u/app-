import 'dart:io';

import 'package:app/models/wordspace_model.dart';
import 'package:app/shared/storage/wordspace_storage.dart';
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
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final user = TextEditingController();
  final email = TextEditingController();
  final url = TextEditingController();
  final pass = TextEditingController();
  final notes = TextEditingController();

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
      appBar: AppBar(title: Text("Nueva Conexión")),

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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(hintText: "Nombre"),
                      validator: (v) => v!.isEmpty ? "Requerido" : null,
                    ),

                    TextFormField(
                      controller: user,
                      decoration: InputDecoration(hintText: "Usuario"),
                      validator: (v) => v!.isEmpty ? "Requerido" : null,
                    ),

                    TextFormField(
                      controller: pass,
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (v) => v!.isEmpty ? "Requerido" : null,
                    ),
                  ],
                ),
              ),

              TextButton(onPressed: pickImage, child: Text('data')),
              SizedBox(height: 24),

              // TextField(decoration: InputDecoration(hintText: "Nombre")),
              // SizedBox(height: 24),

              // TextField(
              //   controller: name,
              //   decoration: InputDecoration(hintText: "Usuario"),
              // ),
              // SizedBox(height: 24),

              // TextField(
              //   // textAlign: TextAlign.center,
              //   // textInputAction: TextInputAction.none,
              //   decoration: InputDecoration(
              //     hintText: "Correo",

              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 24),

              // TextField(decoration: InputDecoration(hintText: "URL")),
              // SizedBox(height: 24),

              // TextField(decoration: InputDecoration(hintText: "Password")),
              SizedBox(height: 24),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(hintText: "Notas"),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final storage = WordspaceStorage();
                  final credential = Credential(
                    name: name.text,
                    user: user.text,
                    password: pass.text,
                    url: url.text,
                    notes: notes.text,
                  );
                  final model = WordspaceModel(
                    name: name.text,
                    description: notes.text,
                    credentials: [credential],
                  );
                  //para q guarde el storage y se dirija al home
                  await WordspaceStorage().setUserSpaceData(model);

                  Navigator.pop(context);
                },
                child: Text('data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
