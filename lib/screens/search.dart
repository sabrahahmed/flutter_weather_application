import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_application/screens/homepage.dart';
import 'package:weather_application/services/weather.dart';
import 'package:weather_application/screens/searchLoading.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:weather_application/screens/loading_screen.dart';

class Search extends StatefulWidget {
  Search({this.locationWeather});
  final locationWeather;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var long;
  var lat;
  var temperature;
  var feelsLike;
  String description;
  var humidity;
  var windSpeed;
  String cityName;
  var country;
  var id;
  double min;
  double max;
  int pressure;

  TextEditingController Controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      long = weatherData['coord']['lon'];
      lat = weatherData['coord']['lat'];
      temperature = weatherData['main']['temp'];
      feelsLike = weatherData['main']['feels_like'];
      description = weatherData['weather'][0]['description'];
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'];
      cityName = weatherData['name'];
      country = weatherData['sys']['country'];
      id = weatherData['weather'][0]['id'];
      min = weatherData['main']['temp_min'];
      max = weatherData['main']['temp_max'];
      pressure = weatherData['main']['pressure'];
    });
  }

  @override
  Widget build(BuildContext context) {
    String background = Weather().getWeatherBackground(id);
    IconData icon = Weather().getWeatherIcon(id);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          backgroundColor: Color(0x44000000),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimSearchBar(
                width: 300,
                textController: Controller,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: Icon(Icons.search, color: Colors.black),
                helpText: 'Search any city!',
                onSuffixTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchLoading(
                      city: Controller.text,
                    );
                  }));
                },
              ),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.house, color: Colors.white, size: 40),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoadingScreen();
                  }));
                },
              ),
              SizedBox(
                width: 1,
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(background),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share_location,
                    color: Colors.red,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    cityName + ', ' + country.toString(),
                    style: TextStyle(
                        fontFamily: 'Merriweather', height: 1.5, fontSize: 30),
                  ),
                ],
              ),
              Center(child: Icon(icon, size: 150)),
              SizedBox(height: 30),
              Text(
                temperature.toStringAsFixed(0) + '°C',
                style: TextStyle(height: 1.5, fontSize: 80),
              ),
              Text(description,
                  style: TextStyle(
                      fontFamily: 'Merriweather', height: 0.5, fontSize: 20)),
              SizedBox(height: 30),
              Table(
                children: [
                  TableRow(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Feels Like:',
                            style: TextStyle(
                                fontFamily: 'Merriweather',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            feelsLike.toStringAsFixed(0) + '°C',
                            style: TextStyle(height: 1.5, fontSize: 30),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Min Temp:',
                            style: TextStyle(
                                fontFamily: 'Merriweather',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            min.toStringAsFixed(0) + '°C',
                            style: TextStyle(height: 1.5, fontSize: 30),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Max Temp:',
                            style: TextStyle(
                                fontFamily: 'Merriweather',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            max.toStringAsFixed(0) + '°C',
                            style: TextStyle(height: 1.5, fontSize: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(''),
                      Text(''),
                      Text(''),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(''),
                      Text(''),
                      Text(''),
                    ],
                  ),
                  TableRow(children: [
                    Column(
                      children: [
                        Text(
                          'Humidity:',
                          style: TextStyle(
                              fontFamily: 'Merriweather',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          humidity.toString() + '%',
                          style: TextStyle(height: 1.5, fontSize: 30),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Windspeed:',
                          style: TextStyle(
                              fontFamily: 'Merriweather',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          windSpeed.toStringAsFixed(0) + '%',
                          style: TextStyle(height: 1.5, fontSize: 30),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Pressure:',
                          style: TextStyle(
                            fontFamily: 'Merriweather',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          pressure.toString() + 'mb',
                          style: TextStyle(height: 1.5, fontSize: 30),
                        ),
                      ],
                    ),
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
