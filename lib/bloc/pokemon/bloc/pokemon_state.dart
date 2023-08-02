part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final List<PokemonListing> pokemonListings;

  const PokemonPageLoadSuccess({required this.pokemonListings});
}

class PokemonPageLoadFailed extends PokemonState {
  final String error;

  const PokemonPageLoadFailed({required this.error});
}
