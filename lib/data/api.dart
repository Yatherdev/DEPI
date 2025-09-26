import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'f69c7d372dd9b998b4dd00a7e3911d56';

  Future<List<dynamic>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));
    if (response.statusCode == 200) return json.decode(response.body)['results'];
    throw Exception('Failed to load popular movies');
  }

  Future<List<dynamic>> fetchNowPlayingMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'));
    if (response.statusCode == 200) return json.decode(response.body)['results'];
    throw Exception('Failed to load now playing movies');
  }

  Future<List<dynamic>> fetchTopRatedMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey'));
    if (response.statusCode == 200) return json.decode(response.body)['results'];
    throw Exception('Failed to load top rated movies');
  }
}