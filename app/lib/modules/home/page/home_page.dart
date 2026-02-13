import 'package:app/models/wordspace_model.dart';
import 'package:app/modules/authenticate/login/page/login_page.dart';
import 'package:app/modules/wordspace/page/wordspace_page.dart';
import 'package:app/modules/wordspace/wigdet/create_name_wordspace.dart';
import 'package:app/shared/helpers/global_helper.dart';
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

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  WordspaceModel? wordspace;
  List<Credential> filterNote = [];

  final storage = Userstorage();
  final searchController = TextEditingController();
  bool isLoading = true;

  List<WordspaceModel> filterWordspaces = [];

  Future<void> loadData() async {
    List<WordspaceModel> wordspaces = await WordspaceStorage()
        .getAllWordspaces();
    setState(() {
      filterWordspaces = wordspaces;
      isLoading = false;
    });
  }

  void filterCredentials(String query) {
    if (wordspace == null) return;

    if (query.isEmpty) {
      setState(() {
        filterNote = wordspace!.credentials;
      });
      return;
    }

    final lowerQuery = query.toLowerCase();
    setState(() {
      filterNote = wordspace!.credentials.where((c) {
        return c.name.toLowerCase().contains(lowerQuery) ||
            c.user.toLowerCase().contains(lowerQuery);
      }).toList();
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

                MaterialPageRoute(
                  builder: (_) => CreateNameWordspace(wordspaceId: 0),
                ),
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
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          searchController.clear();
                          filterCredentials('');
                        },
                      )
                    : null,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: filterWordspaces.isEmpty
                  ? const Center(child: Text("Sin baúles"))
                  : ListView.builder(
                      itemCount: filterWordspaces.length,
                      itemBuilder: (context, index) {
                        final wordspace = filterWordspaces[index];
                        return Card(
                          margin: const EdgeInsets.only(top: 12),
                          child: ListTile(
                            title: Text(wordspace.name),
                            subtitle: Text(
                              '${wordspace.credentials.length} conexiones',
                            ),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            "Confirmar eliminación",
                                          ),
                                          content: const Text(
                                            "¿Estás seguro de eliminar esta conexión?",
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text("Cancelar"),
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(false),
                                            ),
                                            TextButton(
                                              child: const Text("Eliminar"),
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(true),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (confirm == true) {
                                      await WordspaceStorage().deleteWordspace(
                                        wordspace.id,
                                      );

                                      setState(() {
                                        filterWordspaces.removeAt(index);
                                      });

                                      GlobalHelper.showSuccess(
                                        context,
                                        'Conexión eliminada',
                                      );
                                    }
                                    SizedBox(width: 22);
                                  },
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.edit_document,
                                    color: Colors.black,
                                  ),

                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CreateNameWordspace(
                                          wordspaceId: 0,
                                          wordspace: wordspace,
                                        ),
                                      ),
                                    );

                                    if (result == true) {
                                      List<WordspaceModel> wordspaces =
                                          await WordspaceStorage()
                                              .getAllWordspaces();

                                      setState(() {
                                        filterWordspaces = wordspaces;
                                      });
                                      // setState(() {
                                      //   filterWordspaces =
                                      //       updated.id == wordspace.id
                                      //       ? wordspaces
                                      //       : filterWordspaces;
                                      // });
                                    }
                                  },
                                ),
                              ],
                            ),

                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      WordspacePage(wordspace: wordspace),
                                ),
                              );
                              if (result == true) loadData();
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
