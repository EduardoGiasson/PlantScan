import 'package:flutter/material.dart';

class ContaPage extends StatefulWidget {

  @override
  _ContaPageState createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage>{

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title: const Text("Minha Conta"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            /// FOTO DE PERFIL
            Stack(
              alignment: Alignment.bottomRight,

              children: [

                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),

                Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),

                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Editar foto futuramente"),
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Dados atualizados"),
                  ),
                );
              },

              child: const Text("Salvar Alterações"),

            )

          ],
        ),
      ),
    );
  }
}