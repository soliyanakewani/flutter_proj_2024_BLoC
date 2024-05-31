import 'package:flutter_proj_2024/domain/admin/repositories/admin_repository.dart';
import 'package:flutter_proj_2024/infrastructure/admin/data_sources/admin_local_data_source.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminLocalDataSource localDataSource;

  AdminRepositoryImpl(this.localDataSource);

  @override
  Future<List<Map<String, dynamic>>> loadItems() async {
    return await localDataSource.getItems();
  }

  @override
  Future<void> addItem(Map<String, dynamic> item) async {
    await localDataSource.addItem(item);
  }

  @override
  Future<void> updateItem(Map<String, dynamic> item) async {
    await localDataSource.updateItem(item);
  }

  @override
  Future<void> deleteItem(String itemId) async {
    await localDataSource.deleteItem(itemId);
  }
}
