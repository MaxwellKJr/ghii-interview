import 'package:flutter/material.dart';
import 'package:ghii_interview/db_controllers/repository_database.dart';
import 'package:ghii_interview/models/repository/repository.dart';
import 'package:provider/provider.dart';

class SavedRepositoryCard extends StatefulWidget {
  final Repository repository;

  const SavedRepositoryCard({
    super.key,
    required this.repository,
  });

  @override
  State<SavedRepositoryCard> createState() => _SavedRepositoryCardState();
}

class _SavedRepositoryCardState extends State<SavedRepositoryCard> {
  @override
  void initState() {
    super.initState();
    fetchRepos();
  }

  // Fetch all saved repositories
  void fetchRepos() {
    context.read<RepositoryDatabse>().fetchRepositories();
  }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.repository.avatarUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name: ${widget.repository.fullname}'),
                  Text('Private: ${widget.repository.isPrivate}'),
                  Text('Login: ${widget.repository.login}'),
                  Text('Type: ${widget.repository.type}'),
                  Text('Type: ${widget.repository.description}'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            deleteRepository(widget.repository.id);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: const Text("Delete Repo")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
