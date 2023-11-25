import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_flutter/pages/agregar_evento.dart';
import 'package:proyecto_flutter/pages/login.dart';
import 'package:proyecto_flutter/services/firestore_service.dart';
import '../widgets/evento_card.dart';

class paginaInicial extends StatelessWidget {
  final formatoFecha = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Eventos'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Eventos'),
              Tab(text: 'Eventos próximos'),
              Tab(text: 'Eventos pasados'),
            ],
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          actions: [
            FirebaseAuth.instance.currentUser != null
                ? Row(
                    children: [
                      Text('Admin - '),
                      Text('Cerrar Sesión'),
                      SizedBox(width: 5.0),
                      IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => paginaInicial()),
                          );
                        },
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text('Iniciar Sesión'),
                      SizedBox(width: 5.0),
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
        body: TabBarView(
          children: [
            Center(
              child: TabPage1(),
            ),
            Center(
              child: TabPage2(),
            ),
            Center(
              child: TabPage3(),
            ),
          ],
        ),
        floatingActionButton: FirebaseAuth.instance.currentUser != null
            ? FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.add,
                ),
                onPressed: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => agregarEvento());
                  Navigator.push(context, route);
                },
              )
            : null,
      ),
    );
  }
}

class TabPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Eventos Disponibles'),
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: StreamBuilder(
                stream: FirestoreService().eventos(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No hay eventos próximos.'));
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var eventos = snapshot.data!.docs[index];
                        String nombre = eventos['nombre'];
                        String lugar = eventos['lugar'];
                        int likes = eventos['likes'];
                        DateTime fecha = eventos['fecha'].toDate();
                        DateTime hora = eventos['hora'].toDate();
                        String foto = eventos['foto'];
                        String Id = eventos.id;
                        return EventoCard(
                          nombre: nombre,
                          lugar: lugar,
                          likes: likes,
                          fecha: fecha,
                          hora: hora,
                          foto: foto,
                          Id: Id,
                        );
                      },
                    );
                  }
                })));
  }
}

class TabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Eventos próximos en 3 días')),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: StreamBuilder(
                stream: FirestoreService().eventosProximos(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No hay eventos próximos.'));
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var eventos = snapshot.data!.docs[index];
                        String nombre = eventos['nombre'];
                        String lugar = eventos['lugar'];
                        int likes = eventos['likes'];
                        DateTime fecha = eventos['fecha'].toDate();
                        DateTime hora = eventos['hora'].toDate();
                        String foto = eventos['foto'];
                        String Id = eventos.id;
                        return EventoCard(
                          nombre: nombre,
                          lugar: lugar,
                          likes: likes,
                          fecha: fecha,
                          hora: hora,
                          foto: foto,
                          Id: Id,
                        );
                      },
                    );
                  }
                })));
  }
}

class TabPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Eventos finalizados')),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: StreamBuilder(
                stream: FirestoreService().eventosPasados(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No hay eventos finalizados.'));
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var eventos = snapshot.data!.docs[index];
                        String nombre = eventos['nombre'];
                        String lugar = eventos['lugar'];
                        int likes = eventos['likes'];
                        DateTime fecha = eventos['fecha'].toDate();
                        DateTime hora = eventos['hora'].toDate();
                        String foto = eventos['foto'];
                        String Id = eventos.id;
                        return EventoCard(
                            nombre: nombre,
                            lugar: lugar,
                            likes: likes,
                            fecha: fecha,
                            hora: hora,
                            foto: foto,
                            Id: Id);
                      },
                    );
                  }
                })));
  }
}
