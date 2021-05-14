import 'package:climate/screens/city_screen.dart';
import 'package:climate/services/weather.dart';
import 'package:climate/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LocationScreen extends StatefulWidget {
  var locationWeather;
 LocationScreen(final locationWeather )
  {
      this.locationWeather=locationWeather;
  }


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel=WeatherModel();
  int temperature;
  String weatherIcon,messege;
  String cityName;
  
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }



  void updateUI(dynamic weatherData)
  {
    if(weatherData==null)
      {
        Fluttertoast.showToast(
            msg: "Something Went Wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        setState(() {
          temperature=0;
          messege='Unable to collect weather data';
          cityName='your area';
          weatherIcon='Error';
        });
        return;
      }
    setState(() {
      double tempTemperature=weatherData['main']['temp'];
      temperature=tempTemperature.toInt();
      var condition=weatherData['weather'][0]['id'];
      cityName=weatherData['name'];
      weatherIcon=weatherModel.getWeatherIcon(condition);
      messege=weatherModel.getMessage(temperature);
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
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData=await WeatherModel().getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async
                    {
                      var typedCityName=await Navigator.push(context,MaterialPageRoute(builder:(context){
                        return CityScreen();
                      }));
                      if(typedCityName!=null) {
                        var weatherData=await WeatherModel().getCityWeather(typedCityName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                   child: LayoutBuilder(
                     builder: (BuildContext context, BoxConstraints constraints) {
                       return Row(
                         children: <Widget>[
                           Text(
                             '$temperature',
                             style: TextStyle(
                               fontFamily: 'Spartan MB',
                               fontSize: constraints.maxWidth*0.2
                             ),
                           ),
                           Text(
                             weatherIcon,
                             style: TextStyle(
                               fontFamily: 'Spartan MB',
                                 fontSize: constraints.maxWidth*0.15
                             ),
                           ),
                         ],
                       );
                     },
                   ),
              ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(
                      '$messege in $cityName',
                      textAlign: TextAlign.center,
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