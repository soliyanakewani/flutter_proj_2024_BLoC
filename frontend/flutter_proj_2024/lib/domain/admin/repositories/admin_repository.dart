abstract class AdminRepository {
  Future<List<Map<String, dynamic>>> loadItems();
  Future<void> addItem(Map<String, dynamic> item);
  Future<void> updateItem(Map<String, dynamic> item);
  Future<void> deleteItem(String itemId);
}
