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

  Future<String> obtenerNombre() async {
    print("Obteniendo nombre");
    await Future.delayed(Duration(seconds: 2));
    return "Jhonny";
  }

  Future<String> tarea1() {
    return Future.delayed(Duration(seconds: 4), () {
      return "Tarea 1 completada";
    });
  }

  Future<int> dividir(int a, int b) async {
    print("Analizando división");
    if (b == 0) {
      throw Exception("No se puede dividir entre 0");
    }
    await Future.delayed(Duration(seconds: 2));

    return a ~/ b;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final int resultado = await dividir(10, 0);
          } catch (e, stack) {
            print("Hubo un error: $e");
            print("Stack: $stack"); //ayuda a encontrar donde ocurre el error
          }

          // dividir(8, 0).then((respuesta) {
          //   print(respuesta);
          // });

          // // Manera 1 de acceder al contenido
          // tarea1().then((nombre) {
          //   print("NOmbre");
          // });
        },
      ),
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
