import 'package:flutter/material.dart';

import '../dao/planta_dao.dart';
import '../model/planta.dart';
import '../widgets/card_planta.dart';
import 'cadastro_planta_page.dart';

class PlantasPage extends StatefulWidget {

  @override
  State<PlantasPage> createState() => _PlantasPageState();
}

class _PlantasPageState extends State<PlantasPage> {

  final _dao = PlantaDao();

  List<Planta> plantas = [];

  @override
  void initState() {
    super.initState();
    _carregarPlantas();
  }

  Future<void> _carregarPlantas() async {

    final lista = await _dao.listar();

    setState(() {
      plantas = lista;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Plantas Cadastradas"),
      ),

      body: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(20),

            child: Text(
              "Quantidade de plantas: ${plantas.length}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

          ),

          Expanded(

            child: plantas.isEmpty

                ? const Center(
              child: Text(
                "Nenhuma planta cadastrada",
              ),
            )

                : ListView.builder(

              itemCount: plantas.length,

              itemBuilder: (context, index) {

                final planta = plantas[index];

                return CardPlanta(

                  planta: planta,

                  onTap: () async {

                    final plantaEditada =
                    await Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            CadastroPlantaPage(
                              planta: planta,
                            ),

                      ),

                    );

                    if (plantaEditada != null) {

                      await _dao.atualizar(
                        plantaEditada,
                      );

                      _carregarPlantas();
                    }
                  },

                  onDelete: () async {

                    bool? confirmar =
                    await showDialog(

                      context: context,

                      builder: (_) => AlertDialog(

                        title: const Text(
                          "Excluir Planta",
                        ),

                        content: Text(
                          "Deseja excluir ${planta.nome}?",
                        ),

                        actions: [

                          TextButton(

                            onPressed: () {
                              Navigator.pop(
                                context,
                                false,
                              );
                            },

                            child: const Text(
                              "Cancelar",
                            ),

                          ),

                          TextButton(

                            onPressed: () {
                              Navigator.pop(
                                context,
                                true,
                              );
                            },

                            child: const Text(
                              "Excluir",
                            ),

                          ),

                        ],

                      ),

                    );

                    if (confirmar == true) {

                      await _dao.excluir(
                        planta.id!,
                      );

                      _carregarPlantas();

                      if (!mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            "Planta excluída com sucesso",
                          ),
                        ),

                      );
                    }
                  },

                );

              },

            ),

          ),

        ],

      ),

      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.green,

        child: const Icon(Icons.add),

        onPressed: () async {

          final novaPlanta =
          await Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) => CadastroPlantaPage(),
            ),

          );

          if (novaPlanta != null) {

            await _dao.salvar(
              novaPlanta,
            );

            _carregarPlantas();
          }

        },

      ),

    );
  }
}