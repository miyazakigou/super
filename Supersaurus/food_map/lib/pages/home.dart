import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/auth_service.dart';
import '../services/LocationService.dart'; // ★ 正しいパスに修正
import 'package:searchfield/searchfield.dart';
import 'signup.dart';
import 'Settings.dart';
import 'ARPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class City {
  final String name;
  final String zip;
  City(this.name, this.zip);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<SearchFieldListItem<City>> cities;
  SearchFieldListItem<City>? selectedValue;
  String selectedCategory = 'すべて';

  GoogleMapController? mapController; // ★ 現在地移動用

  String? _avatarImagePath;

  final List<String> categories = [
    'すべて',
    'ラーメン',
    'カレー',
    'カフェ',
    '居酒屋',
  ];

  @override
  void initState() {
    cities = [
      City('New York', '10001'),
      City('Los Angeles', '90001'),
    ].map(
      (City ct) => SearchFieldListItem<City>(
        ct.name,
        item: ct,
      ),
    ).toList();
    _loadAvatarImage();
    super.initState();
  }

  Future<void> _loadAvatarImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarImagePath = prefs.getString('avatarImagePath');
    });
  }

  // ★ 現在地へ移動する関数
  Future<void> _goToMyLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      final latLng = LatLng(position.latitude, position.longitude);

      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(latLng, 16),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("エラー: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // GoogleMap背景
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(35.6804, 139.7690),
              zoom: 14,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            myLocationEnabled: true, // ★ 現在地青い丸
            myLocationButtonEnabled: false,
          ),

          // ★ 右下に現在地ボタン
          Positioned(
            bottom: 100,
            right: 5,
            child: FloatingActionButton(
              onPressed: _goToMyLocation,
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.black),
            ),
          ),

          // ★ 左下の AR ボタン（既存）
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ARPage()),
                );
              },
              label: const Text("AR"),
              icon: const Icon(Icons.view_in_ar),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
            ),
          ),

          // 上部のヘッダー部分（既存そのまま）
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SearchField<City>(
                            suggestions: cities,
                            hint: '        検索',
                            maxSuggestionBoxHeight: 300,
                            onSuggestionTap: (item) {
                              setState(() {
                                selectedValue = item;
                              });
                            },
                            selectedValue: selectedValue,
                            suggestionItemDecoration: SuggestionDecoration(
                              padding: const EdgeInsets.all(8),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300, width: 2),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AccountSettingScreen(),
                                ),
                              ).then((_) => _loadAvatarImage()); // 戻ってきたら再読み込み
                            },
                            child: _avatarImagePath != null
                                ? CircleAvatar(
                                    radius: 14,
                                    backgroundImage: FileImage(File(_avatarImagePath!)),
                                  )
                                : const Icon(Icons.account_circle, size: 28),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category) {
                          final isSelected = selectedCategory == category;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isSelected ? Colors.blue : Colors.grey.shade300,
                                foregroundColor:
                                    isSelected ? Colors.white : Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              child: Text(category),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
