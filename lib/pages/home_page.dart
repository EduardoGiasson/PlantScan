import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title: const Text("PlantScan"),
      ),

      drawer: Drawer(

        child: ListView(

          children: [

            const DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_florist, size: 60, color: Colors.green),
                  Text("Menu", style: TextStyle(fontSize: 20))
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Plantas Cadastradas"),

              onTap: (){
                Navigator.pushNamed(context, "/plantas");
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Conta"),

              onTap: (){
                Navigator.pushNamed(context, "/conta");
              },
            ),

          ],
        ),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.local_florist,
              size: 120,
              color: Colors.green,
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(

              icon: const Icon(Icons.camera_alt),

              label: const Text("Identificar Planta"),

              onPressed: (){
                Navigator.pushNamed(context, "/camera");
              },

            )

          ],
        ),
      ),
    );
  }
}