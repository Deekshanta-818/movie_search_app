import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/data_model.dart';

class MovieNotifier extends StateNotifier<List<Movies>> {
  MovieNotifier(): super([]);

  void addMovies(Movies movie) {
    state = [...state, movie];
  }
  
}