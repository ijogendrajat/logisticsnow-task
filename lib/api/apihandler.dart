import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/lorriserviceModel.dart';

// Named constructor ? that make life easy while calling API : Debug and waste time
Future<LorriserviceModel> fetchLocation(
    {required String suggest,
    required int limit,
    required String searchFields}) async {
  try {
    var headers = {
      'X-RapidAPI-Key': 'fbb733a09bmshf581e14bf3e3fe5p114580jsn4dd2800df595',
      'X-RapidAPI-Host': 'cors-proxy4.p.rapidapi.com',
    };
    final Uri uri = Uri.parse(
        'https://cors-proxy4.p.rapidapi.com/?url=https%3A%2F%2Florriservice.azurefd.net%2F%2Fapi%2Fautocomplete%3Fsuggest%3D$suggest%26limit%3D20%26searchFields%3Dnew_locations');

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      //debugPrint(response.body);
      LorriserviceModel lorriserviceModel =
          lorriserviceModelFromJson(response.body);
      debugPrint(lorriserviceModel.value[0].location.location);
      return lorriserviceModel;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}');
      debugPrint('Reason phrase: ${response.reasonPhrase}');
      throw Exception('No Data Found.');
    }
  } catch (error) {
    debugPrint('Error: $error');
    throw Exception('Error: $error');
  }
}
