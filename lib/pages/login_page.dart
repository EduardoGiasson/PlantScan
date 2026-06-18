import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(Icons.local_florist, size: 100, color: Colors.green),

              SizedBox(height: 20),

              Text(
                "PlantScan",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              Text(
                "Tire uma foto da sua planta, e realize o cadastro dela! ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 40),

              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),

              SizedBox(height: 20),

              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Senha"),
              ),

              SizedBox(height: 30),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/home");
                },
                child: Text("Entrar"),
              )

            ],
          ),
        ),
      ),
    );
  }
}