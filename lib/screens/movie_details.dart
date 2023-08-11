import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/data_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movies movie;
  final int id;

  const MovieDetailsScreen({Key? key, required this.movie, required this.id})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final List<String> genres = [];

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    const apiKey = 'd42455879ac7f781d5f06f27adabb0f0';
    final url = 'https://api.themoviedb.org/3/movie/${widget.id}?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final genresList = data['genres'] as List<dynamic>;
        final List<String> extractedGenres =
            genresList.map((genre) => genre['name'] as String).toList();
        setState(() {
          genres.addAll(extractedGenres);
        });
      } else {
        // Handle API error or invalid response
      }
    } catch (e) {
      // Handle any other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // Perform the bookmark action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
                30.0), // Set the border radius to create rounded corners
            child: Image.network(
              widget.movie.image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20), // Add some space between the image and the title
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10), // Add some space between the title and the date
                  Text(
                    "Released Date: ${widget.movie.date}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 138, 128, 128),
                    ),
                  ),
                  const SizedBox(height: 10), // Add some space between the date and genres
                  Text(
                    "Genre: ${genres.join(', ')}", // Join genres with commas
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 138, 128, 128),
                    ),
                  ),
                  const SizedBox(height: 20), // Add some space below the genres
                  const Text(
                    "Overview:", // Overview title
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Update the color to black
                    ),
                  ),
                  const SizedBox(height: 10), // Add some space between title and text
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Text(
                      
                      widget.movie.overview, // Overview text
                      style: const TextStyle(
                        
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
