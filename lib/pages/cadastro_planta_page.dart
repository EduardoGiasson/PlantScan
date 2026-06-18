import 'dart:io';

import 'package:flutter/material.dart';

import '../model/planta.dart';
import '../service/camera_service.dart';

class CadastroPlantaPage extends StatefulWidget {

  final Planta? planta;

  CadastroPlantaPage({this.planta});

  @override
  _CadastroPlantaPageState createState() => _CadastroPlantaPageState();
}

class _CadastroPlantaPageState extends State<CadastroPlantaPage>{

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();

  final _cameraService = CameraService();

  File? imagem;

  @override
  void initState() {
    super.initState();

    if(widget.planta != null){

      nomeController.text = widget.planta!.nome;
      descricaoController.text = widget.planta!.descricao;

      if(widget.planta!.fotoPath != null){
        imagem = File(widget.planta!.fotoPath!);
      }
    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.planta == null
              ? "Cadastrar Planta"
              : "Editar Planta",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(

          child: Column(

            children: [

              GestureDetector(

                onTap: () async {

                  final foto = await _cameraService.tirarFoto();

                  if(foto != null){

                    setState(() {
                      imagem = foto;
                    });

                  }
                },

                child: Container(
                  height: 220,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: imagem != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),

                    child: Image.file(
                      imagem!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 220,
                    ),
                  )
                      : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Icon(Icons.add_a_photo, size: 40),

                      SizedBox(height: 10),

                      Text("Adicionar Foto"),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: nomeController,

                decoration: const InputDecoration(
                  labelText: "Nome da Planta",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: descricaoController,
                maxLines: 3,

                decoration: const InputDecoration(
                  labelText: "Descrição",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  onPressed: (){

                    final planta = Planta(

                      id: widget.planta?.id,

                      nome: nomeController.text,

                      descricao: descricaoController.text,

                      porcentagemIdentificacao:
                      widget.planta?.porcentagemIdentificacao ?? "Manual",

                      fotoPath: imagem?.path,
                    );

                    Navigator.pop(context, planta);
                  },

                  child: const Text("Salvar"),

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}