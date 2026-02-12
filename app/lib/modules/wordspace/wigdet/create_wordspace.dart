import 'dart:io';

import 'package:app/models/wordspace_model.dart';
import 'package:app/shared/helpers/ImageHelper.dart';
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

  final storage = WordspaceStorage();

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

  Future<void> saveCredential() async {
    if (!_formKey.currentState!.validate()) return;

    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 1. Convertir imagen a Base64 si existe
      String? imageBase64;
      if (image != null) {
        imageBase64 = await ImageHelper.imageToBase64(image!);
      }

      // 2. Leer datos actuales del storage
      WordspaceModel? currentWordspace = await storage.getWordspace();

      // 3. Si no existe, crear uno nuevo
      if (currentWordspace == null) {
        currentWordspace = WordspaceModel(
          name: 'Mi Baúl', // Nombre por defecto
          description: 'Mis conexiones seguras',
          credentials: [],
        );
      }

      // 4. Crear nueva credencial
      final newCredential = Credential(
        name: name.text.trim(),
        user: user.text.trim(),
        password: pass.text.trim(),
        url: url.text.trim(),
        notes: notes.text.trim(),
        imageBase64: imageBase64,
      );

      // 5. Agregar a la lista existente
      final updatedCredentials = [
        ...currentWordspace.credentials,
        newCredential,
      ];

      // 6. Crear wordspace actualizado
      final updatedWordspace = WordspaceModel(
        name: currentWordspace.name,
        description: currentWordspace.description,
        credentials: updatedCredentials,
      );

      // 7. Guardar en storage
      await storage.saveWordspace(updatedWordspace);

      // Cerrar loading
      if (!mounted) return;
      Navigator.pop(context);

      // Mostrar éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Credencial guardada'),
          backgroundColor: Colors.green,
        ),
      );

      // Volver al home
      Navigator.pop(context, true);
    } catch (e) {
      // Cerrar loading
      if (!mounted) return;
      Navigator.pop(context);

      // Mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e'), backgroundColor: Colors.red),
      );
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
                      validator: (value) => value!.isEmpty ? "Requerido" : null,
                    ),

                    TextFormField(
                      controller: user,
                      decoration: InputDecoration(hintText: "Usuario"),
                      validator: (value) => value!.isEmpty ? "Requerido" : null,
                    ),

                    TextFormField(
                      controller: pass,
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (value) => value!.isEmpty ? "Requerido" : null,
                    ),
                  ],
                ),
              ),

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
              TextField(decoration: InputDecoration(hintText: "URL")),
              SizedBox(height: 24),

              // TextField(decoration: InputDecoration(hintText: "Password")),
              SizedBox(height: 24),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(hintText: "Notas"),
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: () {}, child: Text('data')),
            ],
          ),
        ),
      ),
    );
  }
}


// ElevatedButton(
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
//                   );
//                   // final model = WordspaceModel(
//                   //   name: name.text,
//                   //   description: notes.text,
//                   //   credentials: [credential],
//                   // );
//                   //para q guarde el storage y se dirija al home
//                   // await WordspaceStorage().setUserSpaceData(model);
//                   await storage.setUserSpaceData(model);

//                   Navigator.pop(context);
//                 },
//                 child: Text('data'),
//               ),



// import 'dart:io';

// import 'package:app/models/wordspace_model.dart';
// import 'package:app/shared/storage/wordspace_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateWordspace extends StatefulWidget {
//   const CreateWordspace({super.key});

//   @override
//   State<CreateWordspace> createState() => _CreateWordspaceState();
// }

// class _CreateWordspaceState extends State<CreateWordspace> {
//   @override
//   void dispose() {
//     name.dispose();
//     user.dispose();
//     pass.dispose();
//     url.dispose();
//     notes.dispose();
//     super.dispose();
//   }

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
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: pickImage,
//                       child: Container(
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
//                     TextFormField(
//                       controller: name,
//                       decoration: InputDecoration(labelText: "Nombre"),
//                       validator: (value) => value!.isEmpty ? "Requerido" : null,
//                     ),
//                     TextFormField(
//                       controller: user,
//                       decoration: InputDecoration(labelText: "Usuario"),
//                       validator: (value) => value!.isEmpty ? "Requerido" : null,
//                     ),
//                     TextFormField(
//                       controller: pass,
//                       decoration: InputDecoration(labelText: "Password"),
//                       validator: (value) => value!.isEmpty ? "Requerido" : null,
//                     ),
//                     TextFormField(
//                       controller: url,
//                       decoration: InputDecoration(labelText: "URL"),
//                       validator: (value) => null,
//                     ),
//                     SizedBox(height: 24),
//                     TextFormField(
//                       controller: notes,
//                       maxLines: 10,
//                       decoration: InputDecoration(labelText: "Notas"),
//                       validator: (value) => null,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (!_formKey.currentState!.validate()) return;
//                     WordspaceModel? current = await WordspaceStorage().getUserSpaceData();
//                     if (current == null) {
//                       current = WordspaceModel(
//                         name: 'Mis Datos',
//                         description: 'Mis conexiones',
//                         credentials: [],
//                       );
//                     }
//                     final newCredential = Credential(
//                       name: name.text.trim(),
//                       user: user.text.trim(),
//                       password: pass.text.trim(),
//                       url: url.text.trim(),
//                       notes: notes.text.trim(),
//                     );
//                     final updatedCredentials = [
//                       ...current.credentials,
//                       newCredential,
//                     ];
//                     final updatedWordspace = WordspaceModel(
//                       name: current.name,
//                       description: current.description,
//                       credentials: updatedCredentials,
//                     );
//                     await WordspaceStorage().setUserSpaceData(updatedWordspace);
//                     if (!mounted) return;
//                     Navigator.pop(context, true);
//                   },
//                   child: const Text(
//                     'GUARDAR',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }