import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_flutter/pages/pagina_inicial.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String mensaje = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: emailCtrl,
                  decoration: InputDecoration(label: Text('Email')),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su mail';
                    }
                  }),
              TextFormField(
                  controller: passwordCtrl,
                  decoration: InputDecoration(label: Text('Password')),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu contraseña';
                    }
                  }),
              BotonLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget BotonLogin() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text(
          'Iniciar Sesion',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            try {
              // Iniciar sesión con Google
              final GoogleSignInAccount? googleUser =
                  await GoogleSignIn().signIn();

              // Obtener las credenciales de Google
              final GoogleSignInAuthentication googleAuth =
                  await googleUser!.authentication;

              if (googleUser.email == 'd.cortes.sa@gmail.com') {
                // Crear credenciales de Firebase con las credenciales de Google
                final AuthCredential credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                );

                // Iniciar sesión con Firebase usando las credenciales de Google
                final UserCredential userCredential = await FirebaseAuth
                    .instance
                    .signInWithCredential(credential);

                // Usuario inició sesión con éxito
                User? user = userCredential.user;
                print('Usuario autenticado con Google: ${user?.displayName}');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => paginaInicial()),
                );
              } else {
                mensaje = 'Credenciales inválidas';
                mostrarSnackBar(context, mensaje);
              }
            } catch (ex) {
              print('Error al autenticar con Google: $ex');
              mensaje = 'Credenciales inválidas';
              mostrarSnackBar(context, mensaje);
            }
          } else {}
        },
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
