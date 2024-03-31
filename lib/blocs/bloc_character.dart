import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/models/character.dart';
import 'package:projet/fetch/fetch_character.dart';

abstract class CharacterEvent {}

class FetchCharacters extends CharacterEvent {
  final int numberOfElements;

  FetchCharacters({required this.numberOfElements});
}
abstract class CharacterState {}

class CharactersInitial extends CharacterState {}

class CharactersLoading extends CharacterState {}

class CharactersLoaded extends CharacterState {
  final List<Character> characters;

  CharactersLoaded({required this.characters});
}

class CharactersError extends CharacterState {
  final String message;

  CharactersError({required this.message});
}


class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharactersInitial()) {
    on<FetchCharacters>((event, emit) async {
      emit(CharactersLoading());
      try {
        final characters = await fetchCharacters(event.numberOfElements);
        emit(CharactersLoaded(characters: characters));
      } catch (error) {
        emit(CharactersError(message: error.toString()));
      }
    });
  }
}
