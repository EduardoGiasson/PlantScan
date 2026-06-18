import 'dart:io';

import 'package:flutter/material.dart';

import '../dao/planta_dao.dart';
import '../model/planta.dart';

class ResultPage extends StatefulWidget {

  final String fotoPath;
  final String nome;
  final String descricao;
  final String porcentagem;

  const ResultPage({
    super.key,
    required this.fotoPath,
    required this.nome,
    required this.descricao,
    required this.porcentagem,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  final _dao = PlantaDao();

  late TextEditingController nomeController;
  late TextEditingController descricaoController;
  late TextEditingController confiancaController;

  @override
  void initState() {
    super.initState();

    nomeController =
        TextEditingController(text: widget.nome);

    descricaoController =
        TextEditingController(text: widget.descricao);

    confiancaController =
        TextEditingController(text: widget.porcentagem);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Resultado"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            ClipRRect(

              borderRadius: BorderRadius.circular(12),

              child: Image.file(
                File(widget.fotoPath),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
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
              controller: confiancaController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Porcentagem de Identificação",
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

                onPressed: () async {

                  final planta = Planta(

                    nome: nomeController.text,

                    descricao: descricaoController.text,

                    porcentagemIdentificacao:
                    confiancaController.text,

                    fotoPath: widget.fotoPath,
                  );

                  await _dao.salvar(planta);

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Planta salva com sucesso",
                      ),
                    ),

                  );

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/home",
                        (route) => false,
                  );

                },

                child: const Text("Salvar"),

              ),

            ),

          ],

        ),

      ),

    );
  }
}