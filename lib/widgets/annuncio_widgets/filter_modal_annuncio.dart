import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';

class FilterModalAnnuncio extends StatefulWidget {
  const FilterModalAnnuncio({super.key, required this.annuncioFiltro});

  final AnnuncioFiltro annuncioFiltro;

  @override
  State<FilterModalAnnuncio> createState() => _FilterModalAnnuncioState();
}

class _FilterModalAnnuncioState extends State<FilterModalAnnuncio> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titoloController;
  Area? areaSelezionata;
  late TextEditingController areaController = TextEditingController();
  TipologiaAnnuncio? tipologiaAnnuncioSelezionata;

  void _resetFields() {
    titoloController.text = '';
    areaController.text = '';
    areaSelezionata = null;
    tipologiaAnnuncioSelezionata = null;
  }

  @override
  void initState() {
    super.initState();
    titoloController =
        TextEditingController(text: widget.annuncioFiltro.titolo);
    widget.annuncioFiltro.area != null
        ? areaSelezionata = widget.annuncioFiltro.area
        : areaSelezionata = null;
    widget.annuncioFiltro.tipologiaAnnuncio != null
        ? tipologiaAnnuncioSelezionata = widget.annuncioFiltro.tipologiaAnnuncio
        : tipologiaAnnuncioSelezionata = null;
  }

  @override
  Widget build(BuildContext context) {
        final areaProvider = Provider.of<AreaProvider>(context, listen: false);
    areaProvider.getAreas();
    final areas = areaProvider.aree;
    final tipologiaAnnuncioProvider = Provider.of<TipologiaAnnuncioProvider>(context, listen: false);
    tipologiaAnnuncioProvider.getTipologiaAnnuncio();
    final tipologiaAnnunci = tipologiaAnnuncioProvider.tipologiaAnnuncio;
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titoloController,
                decoration: const InputDecoration(
                  labelText: 'Titolo',
                ),
                onChanged: (value) {
                  titoloController.text = value;
                }
              ),
             DropdownButtonFormField<int>(
                value: areaSelezionata?.id,
                items: [
                  const DropdownMenuItem<int>(
                    value: 0,
                    child: Text(' - '),
                  ),
                  ...areas.map((Area area) {
                    return DropdownMenuItem<int>(
                      value: area.id,
                      child: Text(area.denominazione ?? 'errore'),
                    );
                  }).toList(),
                ],
                onChanged: (int? value) {
                  setState(() {
                    if (value == 0) {
                      areaSelezionata = null;
                    } else {
                      areaSelezionata =
                          areas.firstWhere((area) => area.id == value);
                    }
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Area',
                ),
              ),
              DropdownButtonFormField<int>(
                value: tipologiaAnnuncioSelezionata?.id,
                items: [
                  const DropdownMenuItem<int>(
                    value: 0,
                    child: Text(' - '),
                  ),
                  ...tipologiaAnnunci.map((TipologiaAnnuncio tipologiaAnnuncio) {
                    return DropdownMenuItem<int>(
                      value: tipologiaAnnuncio.id,
                      child: Text(tipologiaAnnuncio.descrizione ?? 'errore'),
                    );
                  }).toList(),
                ],
                onChanged: (int? value) {
                  setState(() {
                    if (value == 0) {
                      tipologiaAnnuncioSelezionata = null;
                    } else {
                      tipologiaAnnuncioSelezionata =
                          tipologiaAnnunci.firstWhere((area) => area.id == value);
                    }
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Tipologia annunci',
                ),
              ),
              SizedBox(
                height: heightSize(context) * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text('Applica filtri'),
                  ),
                  TextButton(
                      onPressed: _resetFields,
                      child: const Text('Resetta filtri')),
                ],
              ),
            ]
          )
        )
      )
    );
  }
}
