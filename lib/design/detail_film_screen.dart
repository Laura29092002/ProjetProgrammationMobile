import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/blocs/bloc_detail_film.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projet/models/detail_film.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/models/film.dart';
import 'detail_character_screen.dart';



class FilmDetailPage extends StatelessWidget {
  final String apiDetailUrl;
  final Film film;

  const FilmDetailPage({Key? key, required this.apiDetailUrl, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilmBloc()..add(FetchFilmDetail(apiDetailUrl)),
      child: Scaffold(
        body: BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) {
            if (state is FilmLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FilmLoadSuccess) {
              return buildFilmDetailPage(context, state.filmDetail);
            } else if (state is FilmLoadFailure) {
              return Center(child: Text("Error loading comic details"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildFilmDetailPage(BuildContext context, FilmDetail filmDetail) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            film.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Opacity(
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(film.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 21, bottom: 12, left: 14),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          film.imageUrl,
                          width: 95,
                          height: 127,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          film.name,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15,
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

                  ],
                ),
                TabBar(
                  labelColor: Colors.white, // Couleur du texte de l'onglet sélectionné
                  unselectedLabelColor: Colors.white60, // Couleur du texte des onglets non sélectionnés
                  indicatorColor: Colors.orange, // Couleur de l'indicateur de l'onglet sélectionné
                  labelStyle: TextStyle( // Style pour les onglets sélectionnés
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  tabs: [
                    Tab(text: 'Synopsis'),
                    Tab(text: 'Personnages'),
                    Tab(text: 'Infos'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFF1E3243), // Couleur de fond du body
            borderRadius: BorderRadius.only( // Bords arrondis en haut à droite et à gauche
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: ClipRRect( // Pour s'assurer que le contenu ne dépasse pas de la bordure arrondie
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: TabBarView(
              children: [
                // Premier onglet : Description
                SingleChildScrollView(
                  padding: EdgeInsets.all(8.0),
                  child: Html(
                    data: filmDetail.description,
                    style: {
                      "html": Style(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    },
                  ),
                ),
                // Deuxième onglet : Infos
                SingleChildScrollView(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(filmDetail.personnages,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 16,
                        ),),

                    ],
                  ),
                ),

                SingleChildScrollView(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(title: 'Classification', value: filmDetail.rating),
                      InfoRow(title: 'Réalisateur', value: filmDetail.teams),
                      InfoRow(title: 'Scénaristes', value: filmDetail.writers),
                      InfoRow(title: 'Producteurs', value: filmDetail.producers),
                      InfoRow(title: 'Studios', value: filmDetail.studios),
                      InfoRow(title: 'Budget', value: filmDetail.budget),
                      InfoRow(title: 'Recettes au box-office', value: filmDetail.boxOfficeRevenue),
                      InfoRow(title: 'Recettes brutes totales', value: filmDetail.totalRevenue),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


