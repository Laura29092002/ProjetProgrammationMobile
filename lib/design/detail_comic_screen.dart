import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/blocs/bloc_detail_comic.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projet/models/detail_comic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/models/comic.dart';



class ComicDetailPage extends StatelessWidget {
  final String apiDetailUrl;
  final Comic comic;

  const ComicDetailPage({Key? key, required this.apiDetailUrl, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComicBloc()..add(FetchComicDetail(apiDetailUrl)),
      child: Scaffold(
        body: BlocBuilder<ComicBloc, ComicState>(
          builder: (context, state) {
            if (state is ComicLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ComicLoadSuccess) {
              return buildComicDetailPage(context, state.comicDetail);
            } else if (state is ComicLoadFailure) {
              return Center(child: Text("Error loading comic details"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildComicDetailPage(BuildContext context, ComicDetail comicDetail) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            comic.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Opacity(
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(comic.imageUrl),
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
                          comic.imageUrl,
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
                          comic.name,
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
                              'assets/images/ic_books_bicolor.svg',
                              width: 15,
                              height: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'N°${comic.issueNumber}',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 11,
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
                              '${comic.coverDate}',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 11,
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
                    Tab(text: 'Auteurs'),
                    Tab(text: 'Personnages'),
                  ],
                ),
              ],
            ),
          ),
          // Le reste de votre AppBar, comme le fond flexibleSpace, etc.
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFF1E3243),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: TabBarView(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(8.0),
                child: Html(
                  data: comicDetail.description,
                  style: {
                    "html": Style(
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  },
                  // Style your HTML
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  comicDetail.personsInfo,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  comicDetail.characters,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


