import 'package:projet/models/serie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/fetch/fetch_serie.dart';

abstract class SerieEvent {}

class FetchSeries extends SerieEvent {
  final int numberOfElements;

  FetchSeries({required this.numberOfElements});
}

abstract class SerieState {}

class SeriesInitial extends SerieState {}

class SeriesLoadInProgress extends SerieState {}

class SeriesLoadSuccess extends SerieState {
  final List<Serie> series;

  SeriesLoadSuccess(this.series);
}

class SeriesLoadFailure extends SerieState {}


class SerieBloc extends Bloc<SerieEvent, SerieState> {
  SerieBloc() : super(SeriesInitial()) {
    on<FetchSeries>((event, emit) async {
      emit(SeriesLoadInProgress());
      try {
        final series = await fetchSeries(event.numberOfElements);
        emit(SeriesLoadSuccess(series));
      } catch (_) {
        emit(SeriesLoadFailure());
      }
    });
  }
}
