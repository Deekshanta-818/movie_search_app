import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../model/data_model.dart';
import '../../screens/movie_details.dart';

class MovieSlider extends StatelessWidget {
  final List<Movies> movies;

  const MovieSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, _) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movie: movies[index], id: movies[index].id),
              ),
            );
          },
          splashColor: Colors.blue, // Add your desired splash color here
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0), // Add the side margin here
            child: Image.network(
              movies[index].image,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 550,
        // Adjust the height as per your requirement
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3), // Change slide interval as per your preference
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
