import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/api.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Map<String, dynamic>? movieDetails;
  List<dynamic>? cast;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    try {
      final apiService = ApiService();
      final movieResponse = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=${ApiService.apiKey}'),
      );
      final creditsResponse = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/${widget.movieId}/credits?api_key=${ApiService.apiKey}'),
      );

      if (movieResponse.statusCode == 200 && creditsResponse.statusCode == 200) {
        setState(() {
          movieDetails = json.decode(movieResponse.body);
          cast = json.decode(creditsResponse.body)['cast'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : movieDetails == null
          ? Center(child: Text('No details available'))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            if (movieDetails!['poster_path'] != null)
              Center(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movieDetails!['poster_path']}',
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
            SizedBox(height: 20),

            // Title
            Text(
              'Title: ${movieDetails!['title'] ?? 'N/A'}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Overview
            Text(
              'Overview:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              movieDetails!['overview'] ?? 'N/A',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Release Date
            Text(
              'Release Date: ${movieDetails!['release_date'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Status
            Text(
              'Status: ${movieDetails!['status'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Original Language
            Text(
              'Original Language: ${movieDetails!['original_language'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Runtime (Duration)
            Text(
              'Duration: ${movieDetails!['runtime'] ?? 'N/A'} minutes',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Budget
            Text(
              'Budget: \$${movieDetails!['budget'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Revenue
            Text(
              'Revenue: \$${movieDetails!['revenue'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // User Ratings
            Text(
              'User Ratings: ${movieDetails!['vote_average'] ?? 'N/A'}/10 (${movieDetails!['vote_count'] ?? '0'} votes)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Cast
            Text(
              'Cast:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            if (cast != null && cast!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cast!.length,
                itemBuilder: (context, index) {
                  final actor = cast![index];
                  return ListTile(
                    leading: actor['profile_path'] != null
                        ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://image.tmdb.org/t/p/w200${actor['profile_path']}',
                      ),
                    )
                        : Icon(Icons.person),
                    title: Text(actor['name'] ?? 'N/A'),
                    subtitle: Text('Character: ${actor['character'] ?? 'N/A'}'),
                  );
                },
              )
            else
              Text('No cast available'),
          ],
        ),
      ),
    );
  }
}