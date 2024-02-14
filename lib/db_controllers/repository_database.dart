import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ghii_interview/models/repository/repository.dart';

class RepositoryDatabse extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([RepositorySchema], directory: dir.path);
  }

  final List<Repository> savedRepositories = [];

  // Add Repository to Local DB
  Future<void> addRepository(Repository repositoryToSave) async {
    final newRepo = repositoryToSave
      ..fullname
      ..login
      ..isPrivate
      ..avatarUrl
      ..description;

    await isar.writeTxn(() => isar.repositorys.put(repositoryToSave));
    print(newRepo.fullname);
    fetchRepositories();
  }

  // Read Repository from DB
  Future<void> fetchRepositories() async {
    List<Repository> fetchedRepositories =
        await isar.repositorys.where().findAll();

    savedRepositories.clear();
    savedRepositories.addAll(fetchedRepositories);
  }

  // Delete Repository from DB
  Future<void> deleteRepository(int id) async {
    await isar.writeTxn(() => isar.repositorys.delete(id));
    await fetchRepositories();
  }
}
