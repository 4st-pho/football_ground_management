abstract class SharedPreferenceService {
  Future<void> increaseOrderCount();
  Future<void> resetOrderPerday();
  Future<int> getOrderCount();
}
