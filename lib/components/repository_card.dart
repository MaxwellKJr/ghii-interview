import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghii_interview/db_controllers/repository_database.dart';
import 'package:ghii_interview/models/repository/repository.dart';

class RepositoryCard extends StatefulWidget {
  final Repository repository;

  const RepositoryCard({
    super.key,
    required this.repository,
  });

  @override
  State<RepositoryCard> createState() => _RepositoryCardState();
}

class _RepositoryCardState extends State<RepositoryCard> {
  @override
  Widget build(BuildContext context) {
    final RepositoryDatabse newRepo = RepositoryDatabse();

    saveRepository(Repository repository) async {
      newRepo.addRepository(repository);

      Fluttertoast.showToast(
          msg: "Repository Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          fontSize: 16.0);
    }

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
                      FilledButton(
                          onPressed: () async {
                            saveRepository(widget.repository);
                          },
                          child: const Text("Save"))
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
