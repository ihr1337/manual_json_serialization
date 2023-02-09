import 'dart:convert';
import 'package:http/http.dart' as http;

class OfficesList {
  List<Office> offices;
  OfficesList({required this.offices});

  factory OfficesList.fromJson(Map<String, dynamic> json) {
    json;
    List officesJson = json['offices'];

    var mappedList = officesJson.map((e) {
      return Office.fromJson(e);
    });
    mappedList;
    return OfficesList(
      offices: mappedList.toList(),
    );
  }
}

class Office {
  String? name;
  String? address;
  String? image;

  Office({
    required this.name,
    required this.address,
    required this.image,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
        name: json['name'] as String,
        address: json['address'] as String,
        image: json['image'] as String);
  }
}

Future<OfficesList> getOfficesList() async {
  const url = 'https://about.google/static/data/locations.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // print(response.body);

    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
