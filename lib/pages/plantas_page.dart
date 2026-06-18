import 'package:flutter/material.dart';
import '../model/planta.dart';
import '../widgets/card_planta.dart';
import '../dao/planta_dao.dart';
import 'cadastro_planta_page.dart';

class PlantasPage extends StatefulWidget {

  @override
  _PlantasPageState createState() => _PlantasPageState();
}

class _PlantasPageState extends State<PlantasPage>{

  final _dao = PlantaDao();

  List<Planta> plantas = [];

  @override
  void initState() {
    super.initState();
    _carregarPlantas();
  }

  void _carregarPlantas() async {
    final lista = await _dao.listar();

    setState(() {
      plantas = lista;
    });
  }

  @override
  Widget build(BuildContext context){

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
              child: Text("Nenhuma planta cadastrada"),
            )
                : ListView.builder(

              itemCount: plantas.length,

              itemBuilder: (context, index){

                final planta = plantas[index];

                return CardPlanta(
                  planta: planta,

                  onTap: () async {

                    final plantaEditada = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroPlantaPage(planta: planta),
                      ),
                    );

                    if(plantaEditada != null){
                      await _dao.atualizar(plantaEditada);
                      _carregarPlantas();
                    }
                  },
                );
              },
            ),
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,

        onPressed: () async {

          final novaPlanta = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroPlantaPage(),
            ),
          );

          if(novaPlanta != null){
            await _dao.salvar(novaPlanta);
            _carregarPlantas();
          }
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}