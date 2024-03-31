import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/blocs/bloc_detail_character.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projet/models/detail_character.dart';



class CharacterDetailPage extends StatelessWidget {
  final String apiDetailUrl;

  CharacterDetailPage({Key? key, required this.apiDetailUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CharacterBloc()..add(FetchCharacterDetail(apiDetailUrl)),
        child: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CharacterLoadSuccess) {
              return buildCharacterDetailPage(state.characterDetail);
            } else if (state is CharacterLoadFailure) {
              return Center(child: Text("Failed to load character details"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildCharacterDetailPage(CharacterDetail characterDetail) {
    return DefaultTabController(
      length: 2, // Nombre total d'onglets
      child: Scaffold(
        appBar: AppBar(
          title: Text(characterDetail.name, style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 17,
          ),),
          flexibleSpace: Image.network(
            characterDetail.imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          backgroundColor: Colors.transparent,
          bottom: TabBar(
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
              Tab(text: 'Infos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Html(
                data: characterDetail.description,
                style: {
                "html": Style(
                color: Colors.white,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                ),
                },),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(title: 'Nom de super-héros', value: characterDetail.name),
                  InfoRow(title: 'Nom réel', value: characterDetail.realName),
                  InfoRow(title: 'Alias', value: characterDetail.aliases),
                  InfoRow(title: 'Éditeur', value: characterDetail.publisher),
                  InfoRow(title: 'Créateurs', value: characterDetail.creators),
                  InfoRow(title: 'Genre', value: characterDetail.gender),
                  InfoRow(title: 'Date de naissance', value: characterDetail.birth ?? 'Inconnu'),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0) + const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 17,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
