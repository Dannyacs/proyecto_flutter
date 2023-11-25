import 'dart:io';

import 'package:proyecto_flutter/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

class agregarEvento extends StatefulWidget {
  agregarEvento({Key? key}) : super(key: key);

  @override
  State<agregarEvento> createState() => _agregarEventoState();
}

class _agregarEventoState extends State<agregarEvento> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController lugarCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController tipoCtrl = TextEditingController();
  TextEditingController fechaCtrl = TextEditingController();
  TextEditingController horaCtrl = TextEditingController();
  TextEditingController fotoCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime fecha = DateTime.now();
  DateTime hora = DateTime.now();
  final formatoFecha = DateFormat('dd-MM-yyyy');
  final formatoHora = DateFormat('HH:mm');
  String nombre = '';
  String lugar = '';
  String descripcion = '';
  String tipo = 'Deportes';
  String foto = '';
  String estado = 'Activo';
  String mensaje = '';
  int likes = 0;
  File? imagen_lista;
  List<String> tipoevento = ['Bailes', 'Concierto', 'Deportes', 'Recreativo'];

  Future<XFile?> _getImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Evento'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(
                  label: Text('Nombre del evento'),
                ),
                validator: (nombre) {
                  if (nombre!.isEmpty) {
                    return 'Indique el nombre';
                  }

                  if (nombre.length < 3) {
                    return 'Nombre debe ser de al menos 3 letras';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: lugarCtrl,
                decoration: InputDecoration(
                  label: Text('Lugar'),
                ),
                validator: (lugar) {
                  if (lugar!.isEmpty) {
                    return 'Indique lugar';
                  }

                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: tipo ?? '',
                items: tipoevento.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    tipo = value ?? '';
                    tipoCtrl.text = tipo ?? '';
                  });
                },
                decoration: InputDecoration(labelText: 'Tipo'),
              ),
              TextFormField(
                controller: descripcionCtrl,
                decoration: InputDecoration(
                  label: Text('Descripción'),
                ),
                validator: (descripcion) {
                  if (descripcion!.isEmpty) {
                    return 'Agregue una pequeña descripción';
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Text('Fecha del evento: '),
                    Text(formatoFecha.format(fecha),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Spacer(),
                    IconButton(
                      icon: Icon(MdiIcons.calendar),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100, 12, 31),
                        ).then((fechasele) {
                          if (fechasele != null) {
                            setState(() {
                              fecha = fechasele;
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Text('Hora del evento: '),
                    Text(formatoHora.format(hora),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Spacer(),
                    IconButton(
                      icon: Icon(MdiIcons.clock),
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((horasele) {
                          if (horasele != null) {
                            setState(() {
                              DateTime horafinal = DateTime(
                                  fecha.year,
                                  fecha.month,
                                  fecha.day,
                                  horasele.hour,
                                  horasele.minute);
                              hora = horafinal;
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    imagen_lista != null
                        ? Image.file(
                            imagen_lista!,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                        : Placeholder(
                            fallbackHeight: 100,
                            fallbackWidth: 100,
                          ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final imagen = await _getImage();
                        setState(() {
                          imagen_lista = File(imagen!.path);
                        });
                      },
                      child: Text('Seleccionar Imagen'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 231, 12, 56)),
                  child: Text('Agregar evento',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      foto = await uploadImage(imagen_lista!);
                      if (foto.isNotEmpty) {
                        FirestoreService().eventosAgregar(
                          nombreCtrl.text.trim(),
                          lugarCtrl.text.trim(),
                          hora,
                          fecha,
                          descripcionCtrl.text.trim(),
                          tipoCtrl.text.trim(),
                          likes,
                          foto,
                          estado,
                        );
                        mensaje = 'Evento creado con éxito';

                        mostrarSnackBar(context, mensaje);
                      } else {
                        print('Error al obtener la URL de la imagen.');
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void mostrarSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
