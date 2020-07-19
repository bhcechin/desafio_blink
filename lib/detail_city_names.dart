import 'package:flutter/material.dart';

class SaveFavoriteCityAux {
  final String cityName;
  final bool isFavorite;
  SaveFavoriteCityAux(this.cityName, this.isFavorite);
}

class DetailCityName extends StatefulWidget {
  final String cityName;
  final bool isSavedCity;

  DetailCityName({Key key, this.cityName, this.isSavedCity}) : super(key: key);

  @override
  _DetailCityNameState createState() => _DetailCityNameState();
}

class _DetailCityNameState extends State<DetailCityName> {
  final _iconSize = 48.0;
  final _biggerCityName = TextStyle(fontSize: 50.0, fontFamily: 'Rouge');
  bool _isSavedCity;

  void _saveCityName() {
    setState(() {
      _isSavedCity = !_isSavedCity;
    });
  }

  @override
  void initState() {
    _isSavedCity = widget.isSavedCity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/images/logo.jpg',
            fit: BoxFit.contain,
            height: AppBar().preferredSize.height,
          ),
        ),
        actions: <Widget>[
          Container(width: AppBar().preferredSize.height,)
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, SaveFavoriteCityAux(widget.cityName, _isSavedCity));
          return Future(() => false);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(widget.cityName, style: _biggerCityName, textAlign: TextAlign.center),
                padding: EdgeInsets.all(16.0),
              ),
              Container(
                child: Text('Favoritar?'),
                padding: EdgeInsets.only(bottom: 8.0),
              ),
              FlatButton(
                child: _isSavedCity ? Icon(Icons.favorite, color: Colors.pink, size: _iconSize,) : Icon(Icons.favorite_border, color: Colors.black38, size: _iconSize,),
                onPressed: () => _saveCityName(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}