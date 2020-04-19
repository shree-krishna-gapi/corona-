
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<AllCountry>> fetchAllCountry(http.Client client) async {

  String url = "https://covid-19-data.p.rapidapi.com/country/all?format=json";
    final response =  await client.get(Uri.encodeFull(url),
        headers: {
          'x-rapidapi-host': "covid-19-data.p.rapidapi.com",
          'x-rapidapi-key': "4db74056ccmshfca018d3b0f23b2p1278bajsnd3bb10446b68"
        });
    print('---> ${response.body}');
    if (response.statusCode == 200) {
      final stringData = response.body;
      return compute(parseData, stringData);
    } else {
      print("Error getting users.");

    }

}

List<AllCountry> parseData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<AllCountry>((json) => AllCountry.fromJson(json)).toList();

}
class AllCountry {
  final String country;
  final int confirmed;
  final int recovered;
  final int critical;
  final int deaths;
//  "latitude": 33.93911,
//  "longitude": 67.709953
  AllCountry({
    this.country,this.confirmed,this.recovered,this.critical,this.deaths
  });
  factory AllCountry.fromJson(Map<String, dynamic> json) {
    return AllCountry(
      country: json['country'] as String,
      confirmed: json['confirmed'] as int,
      recovered: json['recovered'] as int,
      critical: json['critical'] as int,
      deaths: json['deaths'] as int
    );}
}

