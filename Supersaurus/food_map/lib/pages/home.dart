import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/auth_service.dart';
import 'package:searchfield/searchfield.dart';

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

  @override
  void initState() {
    cities = [
      City('New York', '10001'),
      City('Los Angeles', '90001'),
      
      // Add more cities as needed
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
          const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(35.6804, 139.7690),  //佐賀国東京県東京駅周辺の座標　
          zoom: 14,                           //現在地を表示するやり方がわからなかった
        ),),
        SearchField<City>(
    suggestions: cities,
    hint: 'Search for a city or zip code',
    maxSuggestionBoxHeight: 300,
    onSuggestionTap: (SearchFieldListItem<City> item) {
      setState(() {
        selectedValue = item;
      });
    },
    selectedValue: selectedValue,
    /// customizes the decoration of each suggestion item
    suggestionItemDecoration: SuggestionDecoration(
      padding: EdgeInsets.all(8),
      borderRadius: BorderRadius.all(Radius.circular(2)),
      color: Colors.grey.shade200,
    ),
  ),
        ],
      ),
    );
  }
}
