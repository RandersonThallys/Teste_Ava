abstract class LocalStorage {
  Future<bool> save({required String key, required dynamic value});
  Future<bool> remove({required String key});
  Future load({required String key});
  Future<bool> contains({required String key});
}
