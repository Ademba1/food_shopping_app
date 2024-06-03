import 'package:hive/hive.dart';

part 'auth_data.g.dart';

@HiveType(typeId: 0)
class AuthData extends HiveObject {
  @HiveField(0)
  late String apiKey;
}
