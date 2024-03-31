import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/blocs/bloc_film.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'detail_film_screen.dart';

class FilmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilmBloc()..add(FetchFilms(numberOfElements: 50)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Films les plus populaires',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          backgroundColor: Color(0xFF15232E),
        ),
        body: BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) {
            if (state is FilmsLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FilmsLoadSuccess) {
              return Container(
                color: Color(0xFF15232E),
                child: ListView.builder(
              itemCount: state.films.length,
                itemBuilder: (context, index) {
                  final film = state.films[index];
                  return InkWell(
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilmDetailPage(apiDetailUrl: film.apiDetailUrl, film: film),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 21, bottom: 21),
                      decoration: BoxDecoration(
                        color: Color(0xFF1E3243),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 21, bottom: 12, left: 14),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      film.imageUrl,
                                      width: 129,
                                      height: 163,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      '#${index + 1}',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      film.name,
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/ic_movie_bicolor.svg',
                                          width: 13,
                                          height: 11,
                                          color: Color(0xFF69727D),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${film.runTime} minutes',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/ic_calendar_bicolor.svg',
                                          width: 14,
                                          height: 14,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${film.dateAdded}',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              );
            } else if (state is FilmsLoadFailure) {
              return Center(child: Text("Erreur de chargement"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
