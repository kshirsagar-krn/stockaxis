import '../../core/error/exceptions.dart';
import '../../core/utils/shared_prefs_service.dart';

abstract class LocalDataSource {
  Future<void> cacheUser(String user);
  Future<String?> getCachedUser();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> cacheUser(String user) async {
    try {
      await SharedPrefsService.saveString('cached_user', user);
    } catch (e) {
      throw CacheException(message: 'Failed to cache user');
    }
  }

  @override
  Future<String?> getCachedUser() async {
    try {
      return SharedPrefsService.getString('cached_user');
    } catch (e) {
      throw CacheException(message: 'Failed to get cached user');
    }
  }
}