import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../data/api.dart'; // للدائرة

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State <HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> movies = [];
  bool isLoading = true;
  String currentCategory = 'popular'; // التصنيف الافتراضي

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final apiService = ApiService();
      List<dynamic> fetchedMovies;
      if (currentCategory == 'popular') {
        fetchedMovies = await apiService.fetchPopularMovies();
      } else if (currentCategory == 'now_playing') {
        fetchedMovies = await apiService.fetchNowPlayingMovies();
      } else {
        fetchedMovies = await apiService.fetchTopRatedMovies();
      }
      setState(() {
        movies = fetchedMovies;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void changeCategory(String category) {
    setState(() {
      currentCategory = category;
      isLoading = true;
    });
    fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
        backgroundColor: Colors.blueGrey,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              value: currentCategory,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: Colors.blueGrey,
              style: TextStyle(color: Colors.white),
              underline: Container(height: 0),
              onChanged: (String? newValue) {
                if (newValue != null) changeCategory(newValue);
              },
              items:
                  <String>[
                    'popular',
                    'now_playing',
                    'top_rated',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value == 'popular'
                            ? 'Popular'
                            : value == 'now_playing'
                            ? 'Now Playing'
                            : 'Top Rated',
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : movies.isEmpty
              ? Center(child: Text('No movies available'))
              : GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 كارد في الصف
                  childAspectRatio: 0.7, // نسبة العرض للارتفاع
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  double ratePercent =
                      (movie['vote_average'] ?? 0) /
                      10; // النسبة المئوية للتقييم
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child:
                              movie['poster_path'] != null
                                  ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.broken_image, size: 100),
                                  )
                                  : Icon(Icons.movie, size: 100),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title'] ?? 'No Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    radius: 30.0,
                                    lineWidth: 5.0,
                                    percent: ratePercent > 1 ? 1 : ratePercent,
                                    // الحد الأقصى 100%
                                    center: Text(
                                      '${(ratePercent * 100).toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    progressColor: Colors.green,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Release: ${movie['release_date'] ?? 'N/A'}',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Rating: ${movie['vote_average'] ?? 'N/A'}/10',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
