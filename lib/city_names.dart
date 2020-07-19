import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'detail_city_names.dart';

class CityNames extends StatefulWidget {
  @override
  _CityNamesState createState() => _CityNamesState();
}

class _CityNamesState extends State<CityNames> {
  final _biggerFontMontserrat = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, fontFamily: 'Montserrat', color: Colors.teal);
  final _shownCityNames = <String>[];
  var _cityNames = <String>[];
  var _savedCities = Set<String>();

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/res/Cidades-SP.txt');
  }

  Widget _buildCityNames() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if(i.isOdd) return Divider(color: Colors.grey);
        
        var indexInfinito = i ~/ 2; // indice da lista infinita
        var namesLength = _cityNames.length; // tamanho da lista
        var index = indexInfinito % namesLength; // indice da lista infinita em comparação com a lista finita que deve ser iterada

        if(index >= _shownCityNames.length) {
          _shownCityNames.add(_cityNames[index]);
        }

        return _buildRow(_shownCityNames[index]);
      }
    );
  }

  Widget _buildRow(String cityName) {
    final isSavedCity = _savedCities.contains(cityName);

    return ListTile(
      title: Text(
        cityName,
        style: _biggerFontMontserrat,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isSavedCity ? Icon(Icons.favorite, color: Colors.pink,) : Container(width: 0,),
          Icon(Icons.arrow_forward_ios, color: Colors.black45)
        ]
      ),
      onTap: () => _onTapCity(cityName, isSavedCity),
    );
  }

  void _onTapCity(String cityName, bool isSavedCity) async {
    var detail = DetailCityName(cityName: cityName, isSavedCity: isSavedCity);
    var route = CupertinoPageRoute(builder: (context) => detail);

    await Navigator.of(context).push(route).then((val) {
      if(val.isFavorite) {
        _savedCities.add(val.cityName);
      } else {
        _savedCities.remove(val.cityName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAsset(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          String namesData = snapshot.data;
          _cityNames = namesData.split('\n');
          _cityNames.sort();
          return _buildCityNames();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}