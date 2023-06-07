import 'package:favorite_places/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);
  void addPlace(Place place) {
    state = [...state, place];
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
