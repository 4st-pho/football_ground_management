import 'package:football_ground_management/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServiceImp implements SharedPreferenceService {
  static const orderCountKey = 'order_count';
  static const orderDayKey = 'order_day';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> increaseOrderCount() async {
    final SharedPreferences prefs = await _prefs;
    var feedbackCount = prefs.getInt(orderCountKey) ?? 0;
    feedbackCount = feedbackCount + 1;
    prefs.setInt(orderCountKey, feedbackCount++);
    prefs.setInt(orderDayKey, DateTime.now().day);
  }

  @override
  Future<void> resetOrderPerday() async {
    final SharedPreferences prefs = await _prefs;
    var feedbackDay = prefs.getInt(orderDayKey) ?? 0;
    final now = DateTime.now();
    if (now.day != feedbackDay) {
      prefs.setInt(orderCountKey, 0);
    }
  }

  @override
  Future<int> getOrderCount() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(orderCountKey) ?? 0;
  }
}
