// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logisticsnow/main.dart';
import 'package:logisticsnow/screens/auth/login_screen.dart';
import '../../api/apihandler.dart';
import '../../model/lorriserviceModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LorriserviceModel _cityModel = LorriserviceModel(value: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LogisticsNow"),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                navigatorKey.currentState?.pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              } catch (e) {
                debugPrint('$e');
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) async {
                  if (value.length > 2) {
                    _fetchAndSetCities(value);
                  } else {
                    // Do Nothing :)
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Location / City Name ',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: _cityModel.value.isNotEmpty
                    ? ListView.builder(
                        itemCount: _cityModel.value.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_cityModel.value[index].locationName),
                            onTap: () {
                              _cityDetailsPopup(_cityModel.value[index]);
                            },
                          );
                        },
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Setstate to update cities as user type can state managment later
  Future<void> _fetchAndSetCities(String value) async {
    try {
      LorriserviceModel cityModel = await fetchLocation(
        suggest: value,
        limit: 20,
        searchFields: 'new_locations',
      );
      setState(() {
        _cityModel = cityModel;
      });
    } catch (error) {
      debugPrint('Error fetchLocation API : $error');
    }
  }

  // Extra : Just to verify API Response
  Future<void> _cityDetailsPopup(Value selectedCity) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedCity.locationName),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lat: ${selectedCity.location.lat}'),
              Text('Long: ${selectedCity.location.lon}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
