import 'dart:convert';
import '/utilities/breed.dart';
import 'package:http/http.dart' as http;

class HttpRequest{

  Future<List<Breed>> fetchBreeds(currentPage,rowsPerPage) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-api-key': 'live_GhXL2pki6pFpAKEfE69Ddrr8AJBlF6kog2F0BNYBbYSloX9FXmcolr1mXK5Ni8QN',
    };
    final response = await http.get(Uri.parse('https://api.thedogapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=$currentPage = 0;&limit=$rowsPerPage'),
        headers: headers
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Breed> breeds = [];
      breeds= jsonList.map((breed)=>Breed.fromJson(breed['breeds'][0],breed['url'])).toList();
      return breeds;
    }else {
      throw Exception('Failed to load data');
    }
  }
}