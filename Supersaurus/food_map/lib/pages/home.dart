import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ホーム"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.signOut();
            },
          ),
        ],
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(35.6804, 139.7690),  //佐賀国東京県東京駅周辺の座標　
          zoom: 14,                           //現在地を表示するやり方がわからなかった
        ),
      ),
    );
  }
}
