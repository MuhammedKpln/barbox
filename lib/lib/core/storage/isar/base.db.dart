import 'package:isar/isar.dart';

late Isar isarInstance;

Future<void> initDb(List<CollectionSchema<dynamic>> schemas) async {
  isarInstance = await Isar.open(schemas);
}
