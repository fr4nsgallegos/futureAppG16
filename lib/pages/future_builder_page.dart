import 'package:flutter/material.dart';

class FutureBuilderPage extends StatelessWidget {
  const FutureBuilderPage({super.key});

  Future<String> obtenerMensaje() async {
    await Future.delayed(Duration(seconds: 3));
    throw Exception("EEERRRORRR");
    // return "Datos cargados correctamente";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Future Builder")),
      body: Center(
        child: FutureBuilder(
          future: obtenerMensaje(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("----------------------------------");
            print("snapshot: $snapshot");
            print("estado: ${snapshot.connectionState}");
            print("has error: ${snapshot.hasError}");
            print("error: ${snapshot.error}");
            print("has data: ${snapshot.hasData}");
            print("data: ${snapshot.data}");
            print("----------------------------------");

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return Text(
                snapshot.data!,
                style: TextStyle(fontSize: 24, fontWeight: .bold),
              );
            }
          },
        ),
      ),
    );
  }
}
