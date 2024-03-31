import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/blocs/bloc_detail_serie.dart';
import 'package:projet/models/serie.dart';
import 'package:projet/fetch/fetch_detail_serie.dart';
import 'package:projet/models/detail_serie.dart';

class SerieDetailPage extends StatelessWidget {
  final String apiDetailUrl;
  final Serie serie;

  SerieDetailPage({required this.apiDetailUrl, required this.serie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SerieDetailBloc>(
      create: (context) => SerieDetailBloc()..add(FetchSerieDetail(apiDetailUrl: apiDetailUrl)),
      child: Scaffold(
        body: BlocBuilder<SerieDetailBloc, SerieDetailState>(
          builder: (context, state) {
            if (state is SerieDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SerieDetailLoaded) {
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text(
                      serie.name,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    flexibleSpace: Opacity(
                      opacity: 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(serie.imageUrl),
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
                                    serie.imageUrl,
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
                                    serie.name,
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
                                        'assets/images/ic_publisher_bicolor.svg',
                                        width: 15,
                                        height: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '${serie.publisherName}',
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
                                        'assets/images/ic_tv_bicolor.svg',
                                        width: 15,
                                        height: 11,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '${serie.countOfEpisodes} épisodes',
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
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '${serie.startYear}',
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
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            tabs: [
                              Tab(text: 'Histoire'),
                              Tab(text: 'Personnages'),
                              Tab(text: 'Episodes'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1E3243), // Couleur de fond du body
                      borderRadius: BorderRadius.only(
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
                              data: state.serieDetail.description,
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
                                Text(state.serieDetail.characters,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),),

                              ],
                            ),
                          ),
                          FutureBuilder<List<Episode>>(
                            future: fetchAllEpisodes(state.serieDetail.episodeUrls),
                            builder: (context, episodeSnapshot) {
                              if (episodeSnapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (episodeSnapshot.hasError) {
                                return Center(child: Text("Error: ${episodeSnapshot.error.toString()}"));
                              } else if (episodeSnapshot.hasData) {
                                return ListView.builder(
                                  itemCount: episodeSnapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    Episode episode = episodeSnapshot.data![index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF284C6A),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      margin: EdgeInsets.all(16.0),
                                      padding: EdgeInsets.all(4.0),
                                      child:
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 21, bottom: 12, left: 14),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Image.network(
                                                episode.imageUrl,
                                                width: 126,
                                                height: 105,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Episode #${episode.episodeNumber}',
                                                style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Text(
                                                episode.name,
                                                style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
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
                                                    episode.airDate,
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

                                    );
                                  },
                                );
                              } else {
                                return Center(child: Text('No episodes found'));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is SerieDetailError) {
              return Center(child: Text("Erreur: ${state.message}"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
