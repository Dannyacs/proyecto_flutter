import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

DateTime hoy = DateTime.now();
DateTime fechaLimite = hoy.add(Duration(days: 3));

class FirestoreService {
  Stream<QuerySnapshot> eventos() {
    return FirebaseFirestore.instance
        .collection('eventos')
        .where('estado', isEqualTo: 'Activo')
        .snapshots();
  }

  Future<void> eventosAgregar(
      String nombre,
      String lugar,
      DateTime hora,
      DateTime fecha,
      String descripcion,
      String tipo,
      int likes,
      String foto,
      String estado) async {
    return FirebaseFirestore.instance.collection('eventos').doc().set({
      'nombre': nombre,
      'lugar': lugar,
      'descripcion': descripcion,
      'hora': hora,
      'fecha': fecha,
      'tipo': tipo,
      'likes': likes,
      'foto': foto,
      'estado': estado
    });
  }

  Future<void> eventosBorrar(String Id) async {
    return FirebaseFirestore.instance.collection('eventos').doc(Id).delete();
  }

  Future<void> eventosLike(String Id) async {
    return FirebaseFirestore.instance.collection('eventos').doc(Id).update({
      'likes': FieldValue.increment(1),
    });
  }

  Future<void> eventosEstado(String Id) async {
    return FirebaseFirestore.instance.collection('eventos').doc(Id).update({
      'estado': 'Finalizado',
    });
  }

  Stream<QuerySnapshot> eventosProximos() {
    return FirebaseFirestore.instance
        .collection('eventos')
        .where('fecha', isGreaterThanOrEqualTo: hoy)
        .where('fecha', isLessThanOrEqualTo: fechaLimite)
        .snapshots();
  }

  Stream<QuerySnapshot> eventosPasados() {
    return FirebaseFirestore.instance
        .collection('eventos')
        .where('estado', isEqualTo: 'Finalizado')
        .snapshots();
  }

  Stream<DocumentSnapshot> getEventoPorId(String Id) {
    return FirebaseFirestore.instance.collection('eventos').doc(Id).snapshots();
  }
}

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadImage(File image) async {
  final Reference referencia = storage.ref().child(image.path);
  final UploadTask uploadTask = referencia.putFile(image);

  try {
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    final String url = await snapshot.ref.getDownloadURL();
    return url;
  } catch (error) {
    print('Error al cargar la imagen');
    return '';
  }
}
