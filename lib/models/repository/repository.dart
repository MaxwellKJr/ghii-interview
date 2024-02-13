import 'package:isar/isar.dart';

part 'repository.g.dart';

@collection
class Repository {
  late Id? id;
  late String fullname;
  late bool isPrivate;
  late String login;
  late String avatarUrl;
  late String type;
  late String description;

  Repository({
    this.id,
    required this.fullname,
    required this.isPrivate,
    required this.login,
    required this.avatarUrl,
    required this.type,
    required this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'] as int?,
      fullname: json['full_name'] as String,
      isPrivate: json['private'] as bool,
      login: json['owner']['login'] as String,
      avatarUrl: json['owner']['avatar_url'] as String,
      type: json['owner']['type'] as String,
      description: json['description'] as String? ?? '',
    );
  }
}
