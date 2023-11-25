import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_flutter/services/firestore_service.dart';

import '../pages/evento.dart';

class EventoCard extends StatelessWidget {
  final String nombre;
  final String lugar;
  final int likes;
  final DateTime fecha;
  final DateTime hora;
  final String foto;
  final String descripcion;
  final formatoFecha = DateFormat('dd-MM-yyyy');
  final formatoHora = DateFormat('HH:mm');
  final String Id;
  final String estado;

  EventoCard(
      {this.nombre = '',
      this.lugar = '',
      this.descripcion = '',
      this.likes = 0,
      DateTime? hora,
      DateTime? fecha,
      this.foto = '',
      this.Id = '',
      this.estado = ''})
      : fecha = fecha ?? DateTime.now(),
        hora = hora ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventoDetalle(
                      Id: Id,
                    )),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade50,
            border: Border.all(width: 2, color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                child: Image.network(
                  this.foto,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                this.nombre,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(Icons.pin_drop),
                      Text(
                        this.lugar,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.date_range),
                      Text(
                        formatoFecha.format(this.fecha),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.watch_later),
                      Text(
                        formatoHora.format(this.hora) + 'Hrs',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.star_border),
                      Text(
                        '${this.likes} Me gusta.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  FirestoreService().eventosLike(Id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(130, 40),
                ),
                child: Text(
                  'Me gusta',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
