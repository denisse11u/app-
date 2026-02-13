// import 'dart:io';

// import 'package:app/models/wordspace_model.dart';
// import 'package:app/shared/helpers/ImageHelper.dart';
// import 'package:app/shared/storage/wordspace_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateWordspace extends StatefulWidget {
//   const CreateWordspace({super.key});

//   @override
//   State<CreateWordspace> createState() => _CreateWordspaceState();
// }

// class _CreateWordspaceState extends State<CreateWordspace> {
//   File? image;
//   final picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();

//   final storage = WordspaceStorage();

//   final name = TextEditingController();
//   final user = TextEditingController();
//   final email = TextEditingController();
//   final url = TextEditingController();
//   final pass = TextEditingController();
//   final notes = TextEditingController();

//   Future<void> pickImage() async {
//     final picked = await picker.pickImage(source: ImageSource.gallery);

//     if (picked != null) {
//       setState(() {
//         image = File(picked.path);
//       });
//     }
//   }

//   Future<void> saveCredential() async {
//     if (!_formKey.currentState!.validate()) return;

//     // Mostrar loading
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       // 1. Convertir imagen a Base64 si existe
//       String? imageBase64;
//       if (image != null) {
//         imageBase64 = await ImageHelper.imageToBase64(image!);
//       }

//       WordspaceModel? currentWordspace = await storage.getWordspace();

//       if (currentWordspace == null) {
//         currentWordspace = WordspaceModel(
//           name: 'Mi Baúl',
//           description: 'Mis conexiones seguras',
//           credentials: [],
//           id: 0,
//         );
//       }

//       final newCredential = Credential(
//         name: name.text.trim(),
//         user: user.text.trim(),
//         password: pass.text.trim(),
//         url: url.text.trim(),
//         notes: notes.text.trim(),
//         imageBase64: imageBase64,
//       );

//       final updatedCredentials = [
//         ...currentWordspace.credentials,
//         newCredential,
//       ];

//       final updatedWordspace = WordspaceModel(
//         name: currentWordspace.name,
//         description: currentWordspace.description,
//         credentials: updatedCredentials,
//         id: 0,
//       );

//       await storage.saveWordspace(updatedWordspace);

//       if (!mounted) return;
//       Navigator.pop(context);
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(
//       //     content: Text('Notes guardada'),
//       //     backgroundColor: Colors.green,
//       //   ),
//       // );

//       Navigator.pop(context, true);
//     } catch (e) {
//       if (!mounted) return;
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Nueva Conexión")),

//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Stack(
//                 alignment: Alignment.center,

//                 children: [
//                   CircleAvatar(
//                     radius: 50,

//                     backgroundImage: image != null ? FileImage(image!) : null,
//                     child: image == null ? Icon(Icons.person, size: 40) : null,
//                     // backgroundImage: NetworkImage(
//                     //   'https://marketplace.canva.com/A5alg/MAESXCA5alg/1/tl/canva-user-icon-MAESXCA5alg.png',
//                     // ),
//                     // child: Text(
//                     //
//                     //   style: TextStyle(fontSize: 40, color: Colors.white),
//                     // ),
//                   ),

//                   // TextButton.icon(
//                   //   onPressed: pickImage,
//                   //   label: Icon(Icons.add_a_photo_rounded),
//                   // ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: pickImage,

//                       // child: Container(
//                       //   padding: EdgeInsets.all(6),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.blue,
//                       //     shape: BoxShape.circle,
//                       //   ),
//                       child: Container(
//                         // color: Colors.amberAccent,
//                         child: Icon(Icons.add_a_photo_rounded, size: 20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     SizedBox(height: 24),

//                     TextFormField(
//                       controller: name,
//                       decoration: InputDecoration(
//                         hintText: "Nombre",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       validator: (value) => value!.isEmpty ? "Requerido" : null,
//                     ),

//                     SizedBox(height: 24),

//                     TextFormField(
//                       controller: user,
//                       decoration: InputDecoration(
//                         hintText: "Usuario",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       validator: (value) => value!.isEmpty ? "Requerido" : null,
//                     ),
//                     SizedBox(height: 24),

//                     TextFormField(
//                       controller: pass,
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       validator: (value) => value!.isEmpty ? "Requerido" : null,
//                     ),
//                   ],
//                 ),
//               ),

//               // TextField(decoration: InputDecoration(hintText: "Nombre")),
//               // SizedBox(height: 24),

//               // TextField(
//               //   controller: name,
//               //   decoration: InputDecoration(hintText: "Usuario"),
//               // ),
//               // SizedBox(height: 24),

//               // TextField(
//               //   // textAlign: TextAlign.center,
//               //   // textInputAction: TextInputAction.none,
//               //   decoration: InputDecoration(
//               //     hintText: "Correo",

//               //     border: OutlineInputBorder(
//               //       borderRadius: BorderRadius.circular(12),
//               //     ),
//               //   ),
//               // ),
//               // SizedBox(height: 24),
//               SizedBox(height: 24),

//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "URL",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               TextField(
//                 // maxLines: 10,
//                 decoration: InputDecoration(
//                   hintText: "Notas",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (!_formKey.currentState!.validate()) return;

//                   final storage = WordspaceStorage();
//                   final credential = Credential(
//                     name: name.text,
//                     user: user.text,
//                     password: pass.text,
//                     url: url.text,
//                     notes: notes.text,
//                   );
//                   WordspaceModel? exist = await storage.getUserSpaceData();

//                   List<Credential> creds = exist?.credentials ?? [];

//                   creds.add(credential);

//                   final model = WordspaceModel(
//                     name: "mi espacio",
//                     description: "desc",
//                     credentials: creds,
//                     id: 0,
//                   );
//                   await storage.setUserSpaceData(model);

//                   Navigator.pop(context);
//                 },
//                 child: Text('Guardar'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ElevatedButton(
// //                 onPressed: () async {
// //                   if (!_formKey.currentState!.validate()) return;

// //                   final storage = WordspaceStorage();
// //                   final credential = Credential(
// //                     name: name.text,
// //                     user: user.text,
// //                     password: pass.text,
// //                     url: url.text,
// //                     notes: notes.text,
// //                   );
// //                   WordspaceModel? exist = await storage.getUserSpaceData();

// //                   List<Credential> creds = exist?.credentials ?? [];

// //                   creds.add(credential);

// //                   final model = WordspaceModel(
// //                     name: "mi espacio",
// //                     description: "desc",
// //                     credentials: creds,
// //                   );
//                   // final model = WordspaceModel(
//                   //   name: name.text,
//                   //   description: notes.text,
//                   //   credentials: [credential],
//                   // );
//                   //para q guarde el storage y se dirija al home
//                   // await WordspaceStorage().setUserSpaceData(model);
// //                   await storage.setUserSpaceData(model);

// //                   Navigator.pop(context);
// //                 },
// //                 child: Text('data'),
// //               ),

import 'dart:convert';
import 'dart:io';

import 'package:app/models/wordspace_model.dart';
import 'package:app/shared/storage/wordspace_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateNameWordspace extends StatefulWidget {
  final int wordspaceId;
  final int? credentialIndex;

  final WordspaceModel? wordspace;

  const CreateNameWordspace({
    super.key,
    required this.wordspaceId,
    this.wordspace,
    this.credentialIndex,
  });

  @override
  State<CreateNameWordspace> createState() => _CreateNameWordspaceState();
}

class _CreateNameWordspaceState extends State<CreateNameWordspace> {
  @override
  void initState() {
    if (widget.wordspace != null) {
      name = TextEditingController(text: widget.wordspace!.name);
    } else {
      name = TextEditingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();

    super.dispose();
  }

  late TextEditingController name;

  File? image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  final storage = WordspaceStorage();

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
      appBar: AppBar(
        title: Text("Crear Espacio"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Icon(Icons.add_a_photo_rounded, size: 20),
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
                      decoration: InputDecoration(labelText: "Nombre"),
                      validator: (value) => value!.isEmpty ? "Requerido" : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // List<WordspaceModel> wordspaces = await storage
                  //     .getAllWordspaces();
                  // int newId = wordspaces.isEmpty
                  //     ? 1
                  //     : wordspaces
                  //               .map((w) => w.id)
                  //               .reduce((a, b) => a > b ? a : b) +
                  //           1;

                  // await storage.addWordspace(
                  //   WordspaceModel(
                  //     id: newId,
                  //     name: name.text.trim(),
                  //     description: '',
                  //     credentials: [],
                  //   ),
                  // );

                  // final wordspace = WordspaceModel(
                  //   name: name.text.trim(),
                  //   description: '',
                  //   credentials: [],
                  //   id: 0,
                  // );

                  //  if (widget.wordspace == null) {
                  //   await storage.saveAllWordspaces(
                  //     widget.wordspaceId,

                  //   );
                  // } else {
                  //   await storage.updateCredential(
                  //     widget.wordspaceId,
                  //     widget.credentialIndex!,
                  //     credential,
                  //   );
                  // }

                  if (!_formKey.currentState!.validate()) return;

                  String? imageBase64;
                  if (image != null) {
                    final bytes = await image!.readAsBytes();
                    imageBase64 = base64Encode(bytes);
                  }

                  final wordspace = WordspaceModel(
                    name: name.text.trim(),
                    description: '',
                    credentials: [],
                    id: 0,

                    // imageBase64: imageBase64,
                    // imageBase64: image != null ? base64Encode(await image!.readAsBytes()) : null,
                  );

                  if (widget.wordspace == null) {
                    await storage.addWordspace(wordspace);
                  } else {
                    await storage.updateWordspace(
                      widget.wordspaceId,
                      wordspace,
                    );
                  }

                  Navigator.pop(context, true);
                },
                child: Text(
                  widget.wordspace == null ? "Guardar" : "Actualizar",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
