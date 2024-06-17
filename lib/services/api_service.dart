import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/manga.dart';
import '../models/download_link.dart';

class ApiService {
  static const String apiKey = 'RJ4vrpKqzNm5aEwL';
  static const String baseUrl = 'https://panel.109110.xyz/android/';
  static const Map<String, String> headers = {
    'x-api-key': apiKey,
  };

  static Future<List<Manga>> getAllMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/getAllMovies'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic>? body = json.decode(response.body) as List<dynamic>?;
      if (body == null) {
        throw Exception('Failed to load manga: response body is null');
      }
      return body.map((dynamic item) => Manga.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load manga');
    }
  }

  static Future<List<DownloadLink>> getDownloadLinks(int movieId, int linkOrder) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/getMoviePlayLinks/$movieId/$linkOrder'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic>? body = json.decode(response.body) as List<dynamic>?;
        if (body == null) {
          throw Exception('Failed to load download links: response body is null');
        }
        return body.map((dynamic item) => DownloadLink.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load download links: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in getDownloadLinks: $e');
      throw Exception('Failed to load download links: $e');
    }
  }
}
