import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/lorriserviceModel.dart';

// Named constructor ? that make life easy while calling API : Debug and waste time
Future<LorriserviceModel> fetchLocation(
    {required String suggest,
    required int limit,
    required String searchFields}) async {
  try {
    final Uri uri =
        Uri.parse('https://lorriservice.azurefd.net/api/autocomplete')
            .replace(queryParameters: {
      'suggest': suggest,
      'limit': limit.toString(),
      'searchFields': searchFields,
    });

    final response = await http.get(uri);

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
