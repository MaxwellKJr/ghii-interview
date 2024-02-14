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

  deleteRepository(Id? id) {}

  @override
  Widget build(BuildContext context) {
    final repositoryDatabse = context.watch<RepositoryDatabse>();

    List<Repository> savedRepositories = repositoryDatabse.savedRepositories;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Saved Repositories"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView.builder(
            itemCount: savedRepositories.length,
            itemBuilder: (context, index) {
              final repository = savedRepositories[index];
              print(savedRepositories.length);
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
