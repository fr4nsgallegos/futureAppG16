import 'package:flutter/material.dart';

class AsyncPage extends StatefulWidget {
  AsyncPage({super.key});

  @override
  State<AsyncPage> createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage> {
  String mensaje = "Presione el botón para cargar datos";

  bool cargando = false;

  Future<String> cargarNombreUsuario() async {
    await Future.delayed(Duration(seconds: 4));
    // return "Jhonmny Gallegos";
    throw Exception("No se pudo cargar el usuario");
  }

  Future<void> obtenerUsuario() async {
    setState(() {
      cargando = true;
      mensaje = "Cargando usuario";
    });

    try {
      final nombre = await cargarNombreUsuario();
      setState(() {
        mensaje = "Usuario cargado $nombre";
        cargando = false;
      });
    } catch (e) {
      setState(() {
        mensaje = "Error: no se pudo cargar el usuario";
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Programación asíncrona")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (cargando)
                CircularProgressIndicator()
              else
                Icon(Icons.person, size: 80, color: Colors.blue),
              SizedBox(height: 24),
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: .bold),
              ),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  cargando ? null : obtenerUsuario();
                },
                child: Text("Cargar usuario"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
