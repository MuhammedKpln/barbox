import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late Isar isarInstance;

Future<void> initDb(List<IsarGeneratedSchema> schemas) async {
  final path = await getApplicationDocumentsDirectory();
  print(path);
  isarInstance = await Isar.openAsync(
    schemas: schemas,
    directory: path.path,
    inspector: true,
  );
}
