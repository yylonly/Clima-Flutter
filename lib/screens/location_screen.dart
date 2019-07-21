import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {



  final locationWeather;

  LocationScreen(this.locationWeather);


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel wm = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.locationWeather);


  }

  void updateUI(dynamic deData) {


    setState(() {

      if (deData == null) {

        temperature = 0;
        weatherIcon = 'Error';
        message = 'Unable to get the location';
        cityName = '';

      } else {

        if (deData['main']['temp'] is double) {
          double temp = deData['main']['temp'];
          temperature = temp.toInt();
        } else {
          temperature = deData['main']['temp'];
        }

        var condition = deData['weather'][0]['id'];
        weatherIcon = wm.getWeatherIcon(condition);

        print('weather icon $weatherIcon');
        cityName = deData['name'];

        message = wm.getMessage(temperature);

        print(temperature);
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var newData = await wm.getWeatherData();
                      updateUI(newData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {

                      var typedCityName = await Navigator.push(context, MaterialPageRoute(builder: (context) {

                        return CityScreen();

                      }));

                      if (typedCityName != null) {
                        var data = await wm.getWeatherDatabyCity(typedCityName);

                        updateUI(data);
                      }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
