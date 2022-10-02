class CachedDocument {
  static const String _path = 'path';
  static const String _savedAt = 'saved_at';

  final String path;
  final DateTime savedAt;

  CachedDocument(this.path, this.savedAt);

  Map<String, dynamic> get toMap =>
      {_path: path, _savedAt: savedAt.millisecondsSinceEpoch};

  factory CachedDocument.fromMap(data) => CachedDocument(
      data[_path], DateTime.fromMillisecondsSinceEpoch(data[_savedAt]));
}
