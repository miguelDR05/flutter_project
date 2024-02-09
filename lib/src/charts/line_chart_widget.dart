import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({super.key});

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  var data;

  @override
  void initState() {
    super.initState();

    var r = Random();
    data = List<double>.generate(30, (i) => r.nextDouble() * 1500);
  }

  _onSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    var time;
    final measures = {};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum?.toString() ?? ''; // Si es nulo, utiliza una cadena vacía como valor predeterminado
      for (var datumPair in selectedDatum) {
        measures[datumPair.series.displayName] = datumPair.datum ?? 0.0; // Si es nulo, utiliza 0.0
      }
    }

    print(time);
    print(measures);
  }


  @override
  Widget build(BuildContext context) {
    List<Series<double, int>> series = [ // Cambia el tipo de datos a int
      Series<double, int>(
        id: 'Gasto',
        colorFn: (_, __) => MaterialPalette.pink.shadeDefault,
        domainFn: (value, index) => index ?? 0, // Si es nulo, utiliza 0
        measureFn: (value, _) => value ?? 0.0, // Si es nulo, utiliza 0.0
        data: data,
        strokeWidthPxFn: (_, __) => 4,
      )
    ];

    return LineChart(
      series,
      animate: false,
      selectionModels: [
        SelectionModelConfig(
          type: SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
      domainAxis: const NumericAxisSpec(
        tickProviderSpec: StaticNumericTickProviderSpec(
          [
            TickSpec(0, label: '01'),
            TickSpec(4, label: '05'),
            TickSpec(9, label: '10'),
            TickSpec(14, label: '15'),
            TickSpec(19, label: '20'),
            TickSpec(24, label: '25'),
            TickSpec(29, label: '30'),
          ],
        ),
      ),
      primaryMeasureAxis: const NumericAxisSpec(
        tickProviderSpec: BasicNumericTickProviderSpec(
          desiredTickCount: 4,
        ),
      ),
    );
  }
}
