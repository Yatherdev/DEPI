import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task/Core/custom_color.dart';
import '../../data/api.dart';
import 'movie_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
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
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // إغلاق المنيو
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // إغلاق المنيو
                // يمكن تضيف صفحة Settings هنا
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment<String>(
                  value: 'popular',
                  label: Text('Popular'),
                ),
                ButtonSegment<String>(
                  value: 'now_playing',
                  label: Text('Now Playing'),
                ),
                ButtonSegment<String>(
                  value: 'top_rated',
                  label: Text('Top Rated'),
                ),
              ],
              selected: {currentCategory},
              onSelectionChanged: (Set<String> newSelection) {
                if (newSelection.isNotEmpty) {
                  changeCategory(newSelection.first);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.blueGrey
                    : Colors.grey[300]),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : movies.isEmpty
                ? Center(child: Text('No movies available'))
                : GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                double ratePercent = (movie['vote_average'] ?? 0) / 10;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(movieId: movie['id']),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Card(
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
                              child: movie['poster_path'] != null
                                  ? Image.network(
                                'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
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
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${movie['release_date'] ?? 'N/A'}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    '${movie['vote_average'] ?? 'N/A'}/10',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 150,
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          linearGradient: LinearGradient(
                              colors: [CustomColor.color1, CustomColor.color3]),
                          animation: true,
                          animateToInitialPercent: true,
                          rotateLinearGradient: true,
                          radius: 20.0, // صغّر الدائرة
                          lineWidth: 4.0, // صغّر العرض
                          percent: ratePercent > 1 ? 1 : ratePercent,
                          center: Text(
                            '${(ratePercent * 100).toStringAsFixed(0)}%',
                            style: TextStyle(fontSize: 10), // صغّر الخط
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}