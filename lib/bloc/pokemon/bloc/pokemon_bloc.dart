import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/model/pokemon_listing.dart';
import 'package:flutter_assessment/repo/pokemon_repo.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;
  PokemonBloc({required this.pokemonRepository}) : super(PokemonInitial()) {
    on<PokemonRequest>((event, emit) async {
      emit(PokemonLoadInProgress());
      try {
        final List<PokemonListing> pokemons =
            await pokemonRepository.getPokemons();
        emit(PokemonPageLoadSuccess(pokemonListings: pokemons));
      } catch (e) {
        emit(
          PokemonPageLoadFailed(
            error: e.toString(),
          ),
        );
      }
    });
  }
}
