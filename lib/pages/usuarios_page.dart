import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  late Future<List<String>> usuariosFuture;

  @override
  void initState() {
    super.initState();
    usuariosFuture = obtenerUsuarios();
  }

  Future<List<String>> obtenerUsuarios() async {
    await Future.delayed(Duration(seconds: 5));

    return ["Ana Torres", "Pedro Diaz", "#Jhonny Gallegos", "Merlina Mendoza"];
  }

  void recargarUsuarios() {
    setState(() {
      usuariosFuture = obtenerUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de usuarios"),
        actions: [
          IconButton(
            onPressed: () {
              recargarUsuarios();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: usuariosFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                backgroundColor: Colors.yellow,
                strokeWidth: 10,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error al cargar uusarios",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(child: Text("No hay usuarios disponible"));
          } else {
            final List<String> usuarios = snapshot.data!;

            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (BuildContext context, int index) {
                String usuario = usuarios[index];

                return ListTile(
                  leading: CircleAvatar(child: Text(usuario[0])),
                  title: Text(usuario),
                  subtitle: Text("Usuario activo"),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              },
            );
          }
        },
      ),
    );
  }
}
