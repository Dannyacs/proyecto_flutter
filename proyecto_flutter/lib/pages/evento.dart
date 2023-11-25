import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_flutter/services/firestore_service.dart';

class EventoDetalle extends StatelessWidget {
  final String Id;
  final formatoFecha = DateFormat('dd-MM-yyyy');
  final formatoHora = DateFormat('HH:mm');

  EventoDetalle({required this.Id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalle del evento'),
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: StreamBuilder(
                stream: FirestoreService().getEventoPorId(Id),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.data!.exists) {
                    return Center(child: Text('El evento ya no existe.'));
                  } else {
                    var eventos = snapshot.data!;
                    String nombre = eventos['nombre'];
                    String lugar = eventos['lugar'];
                    String tipo = eventos['tipo'];
                    int likes = eventos['likes'];
                    DateTime fecha = eventos['fecha'].toDate();
                    DateTime hora = eventos['hora'].toDate();
                    String foto = eventos['foto'];
                    String descripcion = eventos['descripcion'];
                    String estado = eventos['estado'];
                    return Container(
                      width: 600,
                      height: 800,
                      margin: EdgeInsets.only(bottom: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: Image.network(
                              foto,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            nombre,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.pin_drop),
                                  Text(
                                    ' Ubicación: ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    lugar,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.pending),
                                  Text(
                                    ' Tipo de evento: ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    tipo,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  Text(
                                    ' Fecha del evento: ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    formatoFecha.format(fecha),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  Text(
                                    ' Hora del evento: ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    formatoHora.format(hora),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  Text(
                                    ' Descripción: ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    descripcion,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star_border),
                                  Text(
                                    ' Likes: ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${likes}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.water),
                                  Text(
                                    ' Estado del evento: ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    estado,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              if (FirebaseAuth.instance.currentUser != null)
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        FirestoreService().eventosEstado(Id);
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Text(
                                        'Finalizar evento',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        FirestoreService().eventosBorrar(Id);
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Text(
                                        'Borrar',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Text(''),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                })));
  }
}
