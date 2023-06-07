import 'package:favorite_places/provider/places_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Your Places', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const AddPlace();
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: PlacesList(places: userPlaces)),
    );
  }
}
