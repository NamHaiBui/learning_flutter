import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final Place place;
  const PlaceDetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      body: Stack(
        children: [
          Image.file(place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
        ],
      ),
    );
  }
}
