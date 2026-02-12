import 'package:app/models/wordspace_model.dart';
import 'package:app/modules/authenticate/login/page/login_page.dart';
import 'package:app/modules/wordspace/page/wordspace_page.dart';
import 'package:app/modules/wordspace/wigdet/create_wordspace.dart';
import 'package:app/shared/storage/user_storage.dart';
import 'package:app/shared/storage/wordspace_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  WordspaceModel? wordspace;
  List<Credential> filteredCredentials = [];

  final storage = Userstorage();
  final searchController = TextEditingController();

  Future<void> loadData() async {
    wordspace = await WordspaceStorage().getUserSpaceData();
    setState(() {
      wordspace = wordspace;
      filteredCredentials = wordspace?.credentials ?? [];
    });
  }

  void filterCredentials(String query) {
    if (wordspace == null) return;

    if (query.isEmpty) {
      setState(() {
        filteredCredentials = wordspace!.credentials;
      });
      return;
    }

    final lowerQuery = query.toLowerCase();
    setState(() {
      filteredCredentials = wordspace!.credentials.where((c) {
        return c.name.toLowerCase().contains(lowerQuery) ||
            c.user.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  Future<void> deleteCredential(int index) async {
    if (wordspace == null) return;

    final updatedCredentials = [...wordspace!.credentials];
    updatedCredentials.removeAt(index);

    final updatedWordspace = WordspaceModel(
      name: wordspace!.name,
      description: wordspace!.description,
      credentials: updatedCredentials,
    );

    await storage.saveWord(updatedWordspace as String);
    loadData();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🗑️ Credencial eliminada'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baúl de Conexiones'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.logout_outlined),

          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateWordspace()),
              );
            },
            icon: Icon(Icons.add_circle_outline_sharp),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: searchController,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Buscar',
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF667eea),
            ),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 20),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),

      // body: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Column(
      //     children: [
      //       TextField(decoration: const InputDecoration(hintText: "Título")),

      //       const SizedBox(height: 20),

      //       TextField(
      //         maxLines: 5,
      //         decoration: const InputDecoration(hintText: "Contenido"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

// import 'package:app/models/wordspace_model.dart';
// import 'package:app/modules/authenticate/login/page/login_page.dart';
// import 'package:app/modules/wordspace/wigdet/create_wordspace.dart';
// import 'package:app/shared/storage/user_storage.dart';
// import 'package:app/shared/storage/wordspace_storage.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   WordspaceModel? wordspace;
//   List<Credential> filteredCredentials = [];

//   final storage = Userstorage();
//   final searchController = TextEditingController();

//   Future<void> loadData() async {
//     wordspace = await WordspaceStorage().getUserSpaceData();
//     setState(() {
//       wordspace = wordspace;
//       filteredCredentials = wordspace?.credentials ?? [];
//     });
//   }

//   void filterCredentials(String query) {
//     if (wordspace == null) return;

//     if (query.isEmpty) {
//       setState(() {
//         filteredCredentials = wordspace!.credentials;
//       });
//       return;
//     }

//     final lowerQuery = query.toLowerCase();
//     setState(() {
//       filteredCredentials = wordspace!.credentials.where((c) {
//         return c.name.toLowerCase().contains(lowerQuery) ||
//             c.user.toLowerCase().contains(lowerQuery);
//       }).toList();
//     });
//   }

//   Future<void> deleteCredential(int index) async {
//     if (wordspace == null) return;

//     final updatedCredentials = [...wordspace!.credentials];
//     updatedCredentials.removeAt(index);

//     final updatedWordspace = WordspaceModel(
//       name: wordspace!.name,
//       description: wordspace!.description,
//       credentials: updatedCredentials,
//     );

//     final wordStorage = WordspaceStorage();
//     await wordStorage.saveWordspace(updatedWordspace);
//     loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Baúl de Conexiones'),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: const Icon(Icons.logout_outlined),

//           onPressed: () => Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => const LoginPage()),
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => CreateWordspace()),
//               );
//             },
//             icon: Icon(Icons.add_circle_outline_sharp),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: searchController,
//               style: const TextStyle(fontSize: 15),
//               decoration: InputDecoration(
//                 hintText: 'Buscar',
//                 hintStyle: TextStyle(color: Colors.grey[400]),
//                 prefixIcon: const Icon(
//                   Icons.search_rounded,
//                   color: Color(0xFF667eea),
//                 ),
//                 suffixIcon: searchController.text.isNotEmpty
//                     ? IconButton(
//                         icon: const Icon(Icons.clear_rounded, size: 20),
//                         onPressed: () {
//                           setState(() {
//                             searchController.clear();
//                             filterCredentials('');
//                           });
//                         },
//                       )
//                     : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 16,
//                 ),
//               ),
//               onChanged: filterCredentials,
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: filteredCredentials.isEmpty
//                   ? const Center(child: Text("Sin datos"))
//                   : ListView.builder(
//                       itemCount: filteredCredentials.length,
//                       itemBuilder: (context, index) {
//                         final c = filteredCredentials[index];
//                         return Card(
//                           margin: const EdgeInsets.only(top: 12),
//                           child: ListTile(
//                             title: Text(c.name),
//                             subtitle: Text(
//                               'Usuario: ' + c.user + '\nURL: ' + c.url,
//                             ),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () => deleteCredential(index),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
