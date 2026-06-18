import 'dart:io';

import 'package:flutter/material.dart';

import '../model/planta.dart';

class CardPlanta extends StatelessWidget {

  final Planta planta;
  final VoidCallback? onTap;

  const CardPlanta({
    super.key,
    required this.planta,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      child: ListTile(

        onTap: onTap,

        leading: planta.fotoPath != null
            ? CircleAvatar(
          backgroundImage: FileImage(
            File(planta.fotoPath!),
          ),
        )
            : const Icon(
          Icons.local_florist,
          color: Colors.green,
        ),

        title: Text(planta.nome),

        subtitle: Text(
          "${planta.descricao} - ${planta.porcentagemIdentificacao}",
        ),

      ),
    );
  }
}