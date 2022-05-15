import 'package:flutter/material.dart';
import 'package:peliculas_app/src/widgets/fondo_homes.dart';
import 'package:peliculas_app/src/widgets/menu_drawer.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          FondoHomes(),
          CustomScrollView(
            slivers: <Widget>[
              _titulos(),
              SliverList(
                delegate: SliverChildListDelegate([
                  posterContact(
                      context,
                      AssetImage("assets/img/lobezno.png"),
                      "Iván Gaitán Muñoz",
                      "www.linkedin.com/in/igaitanm",
                      "github.com/IGaitanM"),
                  SizedBox(
                    height: 20.0,
                  ),
                  posterContact(
                      context,
                      AssetImage("assets/img/superman.png"),
                      "Guillermo Pérez Arias",
                      "www.linkedin.com/in/guiller91",
                      "github.com/guiller91"),
                  SizedBox(
                    height: 20.0,
                  ),
                  posterContact(
                      context,
                      AssetImage("assets/img/flash.png"),
                      "Miguel Pérez Larren",
                      "www.linkedin.com/in/miguel-pérez-larrén-5bb5b2123/",
                      "github.com/miguelperezlarren")
                ]),
              )
            ],
          ),
        ]),
        drawer: DrawerMenu());
  }

  Widget _titulos() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 230.0,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Image(
            image: AssetImage("assets/img/iMOVIE_logo(500x250).png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

Widget posterContact(BuildContext context, AssetImage imagen, String nombre,
    String linkedin, String gitHub) {
  return Container(
    child: Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image(
            image: imagen,
            height: 150.0,
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.star_border, color: Colors.yellowAccent),
              Text(nombre,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis),
              Text(linkedin,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Text(gitHub, style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
