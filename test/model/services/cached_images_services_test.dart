import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse/model/cached_document.dart';
import 'package:labhouse/model/services/cached_images_services.dart';

main() {
  group("chached images services test", () {
    test("save document", () async {
      final CachedDocument cachedDocument =
          CachedDocument("path example", DateTime.now());

      //await cachedImagesServices.initCashedDb('./');
      await CachedImagesServices.saveDocument(cachedDocument);
    });

    test("fetch document", () async {
      //await cachedImagesServices.initCashedDb('./');
      final dataResult = await CachedImagesServices.getCachedDocuments();
      expect(dataResult.length, isNonZero);
    });
  });
}
