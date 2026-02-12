import 'package:app/models/wordspace_model.dart';
import 'package:app/modules/authenticate/login/page/login_page.dart';
import 'package:app/modules/wordspace/page/wordspace_page.dart';
import 'package:app/modules/wordspace/wigdet/create_name_wordspace.dart';
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
  List<Credential> filterNote = [];

  final storage = Userstorage();
  final searchController = TextEditingController();
  bool isLoading = true;
  bool istitle = true;

  List<WordspaceModel> filterWordspaces = [];

  Future<void> loadData() async {
    wordspace = await WordspaceStorage().getUserSpaceData();
    setState(() {
      wordspace = wordspace;
      filterNote = wordspace?.credentials ?? [];
      isLoading = false;
    });
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
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateNameWordspace()),
              );
              if (result == true) {
                loadData();
              }
            },
            icon: Icon(Icons.add_circle_outline_sharp),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Buscar',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF667eea),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filterNote.isEmpty
                  ? const Center(child: Text("Sin datos"))
                  : ListView.builder(
                      itemCount: filterNote.length,
                      itemBuilder: (context, index) {
                        final c = filterNote[index];
                        return Card(
                          margin: const EdgeInsets.only(top: 12),
                          child: GestureDetector(
                            child: ListTile(title: Text(c.name)),
                            onTap: () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const WordspacePage(),
                                ),
                              ),
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
