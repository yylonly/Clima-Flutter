import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {

  void getLocation() async {

    WeatherModel wm = WeatherModel();
    var data = await wm.getWeatherData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {

      return LocationScreen(data);
    }));

  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}

