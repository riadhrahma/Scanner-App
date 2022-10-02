import 'package:hive/hive.dart';
import 'package:labhouse/model/cached_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CachedImagesServices {
  static const String boxName = 'documents';
  static const String dataKey = 'data';

  static BoxCollection? collection;

  static Future<List<CachedDocument>> getCachedDocuments() async {
    try {
      initCashedDb();
      final CollectionBox<Map<dynamic, dynamic>> dataBox =
          await collection!.openBox<Map>(dataKey);

      final Map<String, dynamic> dataResult = await dataBox.getAllValues();

      return dataResult.values.map((e) => CachedDocument.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> saveDocument(CachedDocument cachedDocument) async {
    initCashedDb();
    final CollectionBox<Map<dynamic, dynamic>> dataBox =
        await collection!.openBox<Map>(dataKey);
    final String documentId = const Uuid().v4();

    await dataBox.put(documentId, cachedDocument.toMap);
  }

  ///Nb this is the test version of initCashedDb
  // @override
  // Future<void> initCashedDb(String path) async {
  //   collection = await BoxCollection.open(
  //     boxName,
  //     {dataKey},
  //     path: path,
  //   );
  // }

  ///Nb this is the release version of initCashedDb

  static Future<void> initCashedDb() async {
    if (collection == null) {
      final directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
      collection = await BoxCollection.open(
        boxName,
        {dataKey},
        path: directory.path,
      );
    }
  }
}
