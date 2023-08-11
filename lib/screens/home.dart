import 'package:flutter/material.dart';
import '../widgets/home_screen_widgets/movies_slider.dart';
import '../widgets/home_screen_widgets/text_field.dart';
import '../widgets/home_screen_widgets/top_info.dart';
import '../model/data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Movies> movies = [];
  final List<Movies> selectedMovies = [];
  bool isClicked = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const String apiKey = 'd42455879ac7f781d5f06f27adabb0f0';
    const String apiUrl =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc&include_adult=false&include_video=false&with_poster=true';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        setState(() {
          movies.clear();
          for (var result in results) {
            movies.add(Movies(
              id: result['id'],
              title: result['title'],
              image: 'https://image.tmdb.org/t/p/w500${result['poster_path']}',
              date: result['release_date'],
              overview: result['overview'],
            ));
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<void> searchMovie(String query) async {
    setState(() {
      isLoading = true;
      isClicked = true;
    });
    const String apiKey = 'd42455879ac7f781d5f06f27adabb0f0';
    final String apiUrl =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&include_adult=false';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        setState(() {
          selectedMovies.clear();
          for (var result in results) {
            selectedMovies.add(Movies(
              id: result['id'],
              title: result['title'],
              image: 'https://image.tmdb.org/t/p/w500${result['poster_path']}',
              date: result['release_date'],
              overview: result['overview'],
            ));
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
      // ignore: empty_catches
    } catch (error) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = MovieSlider(movies: movies);
    if (isClicked && selectedMovies.isNotEmpty) {
      content = MovieSlider(
        movies: selectedMovies,
      );
    }
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TopInfo(),
            const SizedBox(height: 20),
            TextInput(
              onQuery: (query) {
                searchMovie(query);
              },
            ),
            const SizedBox(height: 20),
            movies.isEmpty || isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Show CircularProgressIndicator when movies list is empty
                : content,
          ],
        ),
      ),
    );
  }
}
