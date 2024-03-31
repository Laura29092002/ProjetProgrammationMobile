import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/blocs/bloc_serie.dart';
import 'package:projet/blocs/bloc_comic.dart';
import 'package:projet/blocs/bloc_film.dart';
import 'package:projet/blocs/bloc_character.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/models/home.dart';
import 'package:projet/main.dart';
import 'package:projet/blocs/bloc_news.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF15232E),
        appBarTheme: AppBarTheme(
          color: Color(0xFF15232E),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bienvenue!',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                child: SvgPicture.asset('assets/images/astronaut.svg'),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Container(),
          ),
        ),
        body: SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16, left: 20),
            decoration: BoxDecoration(
              color: Color(0xFF1E3243),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '●',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Séries populaires',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp(index: 2)),
                        );
                        print('Voir plus de séries');
                      },
                      child: Text('Voir Plus'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
                BlocProvider<SerieBloc>(
                  create: (context) => SerieBloc()..add(FetchSeries(numberOfElements: 5)),
                  child: SeriesSection(),
                ),
              ],
            ),

          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(top: 16, left: 20),
            decoration: BoxDecoration(
              color: Color(0xFF1E3243),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '●',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Comics populaires',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp(index: 1)),
                        );
                        print('Voir plus de comics');
                      },
                      child: Text('Voir Plus'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
                BlocProvider<ComicBloc>(
                  create: (context) => ComicBloc()..add(FetchComics(numberOfElements: 5)),
                  child: ComicsSection(),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(top: 16, left: 20),
            decoration: BoxDecoration(
              color: Color(0xFF1E3243),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '●',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Films populaires',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp(index: 3)),
                        );

                        print('Voir plus de films');
                      },
                      child: Text('Voir Plus'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),

                BlocProvider<FilmBloc>(
                  create: (context) => FilmBloc()..add(FetchFilms(numberOfElements: 5)),
                  child: FilmsSection(),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(top: 16, left: 20),
            decoration: BoxDecoration(
              color: Color(0xFF1E3243),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '●',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Personnages populaires',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                BlocProvider<CharacterBloc>(
                  create: (context) => CharacterBloc()..add(FetchCharacters(numberOfElements: 5)),
                  child: CharactersSection(),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(top: 16, left: 20),
            decoration: BoxDecoration(
              color: Color(0xFF1E3243),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '●',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Dernières actualités',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                BlocProvider<NewsBloc>(
                  create: (context) => NewsBloc()..add(FetchNews(numberOfElements: 2)),
                  child: NewsSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
      ),
    );
  }
}


class SeriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SerieBloc, SerieState>(
      builder: (context, state) {
        if (state is SeriesLoadInProgress) {
          return CircularProgressIndicator();
        } else if (state is SeriesLoadSuccess) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.series.map((serie) => SerieItem(serie: serie)).toList(),
            ),
          );
        }
        return Container();
      },
    );
  }
}


class ComicsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComicBloc, ComicState>(
      builder: (context, state) {
        if (state is ComicsLoadInProgress) {
          return CircularProgressIndicator();
        } else if (state is ComicsLoadSuccess) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.comics.map((comic) => ComicItem(comic: comic)).toList(),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class FilmsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmBloc, FilmState>(
      builder: (context, state) {
        if (state is FilmsLoadInProgress) {
          return CircularProgressIndicator();
        } else if (state is FilmsLoadSuccess) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.films.map((film) => FilmItem(film: film)).toList(),
            ),
          );
        }
        return Container();
      },
    );
  }
}


class CharactersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is CharactersLoading) {
          return CircularProgressIndicator();
        } else if (state is CharactersLoaded) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.characters.map((character) => CharacterItem(character: character)).toList(),
            ),
          );
        } else if (state is CharactersError) {
          return Text(state.message);
        }
        return Container();
      },
    );
  }
}


class NewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return CircularProgressIndicator();
        } else if (state is NewsLoaded) {
          return Column(
            children: state.news.map((article) => ArticleItem(article: article)).toList(),
          );
        } else if (state is NewsError) {
          return Text(state.message);
        }
        return Container();
      },
    );
  }
}

