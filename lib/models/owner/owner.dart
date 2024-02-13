import 'package:isar/isar.dart';

part 'owner.g.dart';

@collection
class Owner {
  Id? id;
  final String avatarUrl;
  final String type;

  Owner({this.id, required this.avatarUrl, required this.type});
}
