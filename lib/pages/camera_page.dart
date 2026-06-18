import 'dart:io';

import 'package:flutter/material.dart';

import '../api/plant_api_service.dart';
import '../model/identificacao_planta.dart';
import '../service/camera_service.dart';
import 'result_page.dart';

class CameraPage extends StatefulWidget {

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  final _cameraService = CameraService();
  final _plantApi = PlantApiService();

  bool carregando = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _abrirCamera();
    });
  }

  Future<void> _abrirCamera() async {

    final File? foto = await _cameraService.tirarFoto();

    if (foto == null) {

      if (mounted) {
        Navigator.pop(context);
      }

      return;
    }

    setState(() {
      carregando = true;
    });

    final IdentificacaoPlanta? resultado =
    await _plantApi.identificarPlanta(foto);

    if (!mounted) return;

    setState(() {
      carregando = false;
    });

    if (resultado == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Não foi possível identificar a planta",
          ),
        ),
      );

      Navigator.pop(context);

      return;
    }

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder: (_) => ResultPage(
          fotoPath: foto.path,
          nome: resultado.nome,
          descricao: resultado.descricao,
          porcentagem: resultado.porcentagem,
        ),

      ),

    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Capturar Planta"),
      ),

      body: Center(

        child: carregando

            ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircularProgressIndicator(),

            SizedBox(height: 20),

            Text(
              "Identificando planta...",
              style: TextStyle(fontSize: 18),
            ),

          ],
        )

            : const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.camera_alt,
              size: 120,
            ),

            SizedBox(height: 20),

            Text(
              "Abrindo câmera...",
              style: TextStyle(fontSize: 18),
            ),

          ],
        ),
      ),
    );
  }
}