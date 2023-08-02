import 'dart:convert';

import 'package:flutter_assessment/model/pokemon_listing.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<List<PokemonListing>> getPokemons() async {
    final queryParameters = {
      'limit': '100',
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon/', queryParameters);

    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    return PokemonListing.fromJsonList(json['results']);
  }
}
