import 'dart:io';

import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/provider/places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  var _enteredName = '';
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  void _savePlace() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref
          .read(userPlaceProvider.notifier)
          .addPlace(Place(title: _enteredName, image: _selectedImage!));
    }
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new Place')),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text('Title')),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Must be between 1 and 50 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredName = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                LocationInput(),
                const SizedBox(height: 16),
                ImageInput(
                  onPickImage: (image) {
                    _selectedImage = image;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _savePlace,
                  icon: const Icon(Icons.add),
                  label: Text('Add Place',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground)),
                ),
              ],
            ),
          )),
    );
  }
}
