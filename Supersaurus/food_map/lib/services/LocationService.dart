import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 位置情報サービス ON かチェック
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("位置情報サービスがOFFです");
    }

    // 権限チェック
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("位置情報の権限が拒否されました");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("位置情報が永久に拒否されています。設定から許可してください。");
    }

    // ★ 必ず精密位置を取得するようにする
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      timeLimit: const Duration(seconds: 10), // ★ 測位待ち強化
    );
  }
}
