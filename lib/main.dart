import 'dart:convert';

import 'package:data_table/model/assetData.dart';
import 'package:data_table/model/yearlyData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:table_sticky_headers/table_sticky_headers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<List<AssetData>> getJsonDecodedData() async {
    final dataInString = await rootBundle.loadString('assets/assets.json');
    final Map<String, dynamic> assetData = jsonDecode(dataInString)['assets'];
    List<AssetData> assetsDataList = [];
    for (var e in assetData.entries) {
      if ((e.value as List<dynamic>).isNotEmpty) {
        assetsDataList.add(AssetData(
          year: e.key,
          yearlyData: (e.value as List<dynamic>).map((e1) => YearlyData.fromMap(e1)).toList(),
        ));
      }
    }
    return assetsDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getJsonDecodedData(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return tableGrid(snapshot.data!);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          })),
    );
  }

  Widget tableGrid(List<AssetData> data) {
    final assetNameList = data.first.yearlyData.map((e) => e.assetName).toList();
    return StickyHeadersTable(
      columnsLength: data.length,
      showHorizontalScrollbar: true,
      cellDimensions: const CellDimensions.fixed(contentCellWidth: 150, contentCellHeight: 50, stickyLegendWidth: 180, stickyLegendHeight: 50),
      rowsLength: assetNameList.length,
      columnsTitleBuilder: (i) => Text(data[i].year, textAlign: TextAlign.center),
      rowsTitleBuilder: (i) => Text(assetNameList[i], textAlign: TextAlign.center),
      contentCellBuilder: (i, j) => Text(data[i].yearlyData[j].assetValue.toString(), textAlign: TextAlign.center),
      legendCell: const Text('Particulars'),
    );
  }
}
