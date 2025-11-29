import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/auth_service.dart';
import 'package:searchfield/searchfield.dart';
import 'signup.dart';
import 'Settings.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // GoogleMap背景
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(35.6804, 139.7690),
              zoom: 14,
            ),
          ),
          
          // 上部のヘッダー部分
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
                    // 検索バーとユーザーアイコンの行
                    Row(
                      children: [
                        // 検索バー
                        Expanded(
                          child: SearchField<City>(
                            suggestions: cities,
                            hint: '        検索',
                            maxSuggestionBoxHeight: 300,
                            onSuggestionTap: (SearchFieldListItem<City> item) {
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
                        // ユーザーアイコン
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300, width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.account_circle, size: 28),
                            onPressed: () {
                              // ユーザーメニューの処理
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (_) => const AccountSettingScreen(),
                                ),
                            );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // カテゴリーボタン
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
                                backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
                                foregroundColor: isSelected ? Colors.white : Colors.black87,
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
