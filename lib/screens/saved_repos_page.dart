import 'package:flutter/material.dart';
import 'package:ghii_interview/db_controllers/repository_database.dart';
import 'package:ghii_interview/models/repository/repository.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class SavedReposPage extends StatefulWidget {
  const SavedReposPage({super.key});

  @override
  State<SavedReposPage> createState() => _SavedReposPageState();
}

class _SavedReposPageState extends State<SavedReposPage> {
  @override
  void initState() {
    super.initState();
    fetchRepos();
  }

  // Fetch all saved repositories
  void fetchRepos() {
    context.read<RepositoryDatabse>().fetchRepositories();
  }

  @override
  Widget build(BuildContext context) {
    final repositoryDatabse = context.watch<RepositoryDatabse>();

    List<Repository> savedRepositories = repositoryDatabse.savedRepositories;

    // Delete Repository
    void deleteRepository(id) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Delete this repo?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        context.read<RepositoryDatabse>().deleteRepository(id);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Yes, delete",
                      ))
                ],
              ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Saved Repositories"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: savedRepositories.isEmpty
            ? const Center(
                child: Text("No repositories have been saved."),
              )
            : ListView.builder(
                itemCount: savedRepositories.length,
                itemBuilder: (context, index) {
                  final repository = savedRepositories[index];
                  return ListTile(
                    title: Text(repository.fullname),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () => deleteRepository(repository.id),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  );
                }));
  }
}
