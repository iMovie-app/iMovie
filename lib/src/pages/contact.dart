import 'package:flutter/material.dart';
import 'package:peliculas_app/src/widgets/fondo_homes.dart';
import 'package:peliculas_app/src/widgets/menu_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                  posterContactLeft(
                      context,
                      AssetImage("assets/img/lobezno.png"),
                      "Iván Gaitán Muñoz",
                      "linkedin.com/in/igaitanm",
                      "github.com/IGaitanM"),
                  SizedBox(
                    height: 20.0,
                  ),
                  posterContactRigth(
                      context,
                      AssetImage("assets/img/superman.png"),
                      "Guillermo Pérez Arias",
                      "linkedin.com/in/guiller91",
                      "github.com/guiller91"),
                  SizedBox(
                    height: 20.0,
                  ),
                  posterContactLeft(
                      context,
                      AssetImage("assets/img/flash.png"),
                      "Miguel Pérez Larren",
                      "linkedin.com/in/miguel-pérez-larrén-5bb5b2123/",
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

Widget posterContactLeft(BuildContext context, AssetImage imagen, String nombre,
    String linkedin, String gitHub) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: imagen,
              height: 150.0,
              width: 160,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.star_border, color: Colors.yellowAccent),
                Text(nombre,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis),
                InkWell(
                    child: Text(linkedin,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis),
                    onTap: () => launchUrlString('https://$linkedin')),
                InkWell(
                    child: Text(gitHub,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis),
                    onTap: () => launchUrlString('https://$gitHub')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget posterContactRigth(BuildContext context, AssetImage imagen,
    String nombre, String linkedin, String gitHub) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.star_border, color: Colors.yellowAccent),
                Text(nombre,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis),
                InkWell(
                    child: Text(linkedin,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis),
                    onTap: () => launchUrlString('https://$linkedin')),
                InkWell(
                    child: Text(gitHub,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis),
                    onTap: () => launchUrlString('https://$gitHub')),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: imagen,
              height: 150.0,
              width: 160,
            ),
          ),
        ],
      ),
    ),
  );
}
