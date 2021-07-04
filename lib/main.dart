import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutte.dart';
import 'package:http/http.dart' as http;
import 'dart:convert ';


void main() => runApp(
  MaterialApp(
    title: "Wealther App",
    home: Home(), 
  )//MaterialApp
);

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

var temp;
var description;
var currently;
var humidity;
var windSpeed;

Future getWeather () async {
  http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=Akure&appid=b39f91cde5ad314238fbb2af4b6479f8");
  var results = jsonDecode(response.body);
  setState(() {
    this.temp = results['main']['temp'];
    this.description = results['weather'][0]['description'];
    this.currently = results['weather'][0]['main'];
    this.humidity = results['main']['humidity'];
    this.windSpeed = results['wind']['speed'];
  });
}


@override
void initState() { 
  super.initState();
  this.getWeather();
  
}

  @override
  Widget @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.Only(bottom: 10.0)
                  child: Text(
                    "Currently in Nigeria",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500
                    ), // TextStyle
                  ), // Text
                ), // Padding
                Text(
                  temp !=null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w650 
                  ), //TextStyle
                ), //Text
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w650
                    ), // TextStyle
                  ), // Text
                ), // Padding
              ], // <Widget>[]
            ), // Column
          ), // Container
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(23.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Falcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp !=null ? temp.toString() + "\u00B0" : "Loading"),
                  ), // ListTile
                  ListTile(
                    leading: Falcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null ? description.toString() : "Loading"),
                  ), // ListTile
                  ListTile(
                    leading: Falcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                  ), // ListTile
                  ListTile(
                    leading: Falcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading"),
                  ), // ListTile
                ], // <Widget>[]
              ), // ListView
            ), // Padding
          ), // Expanded
        ], // <Widget>[]
      ), // Column
    ); // Scaffold
  }
}
