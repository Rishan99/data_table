import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:data_table/model/yearlyData.dart';

class AssetData {
  final String year;
  final List<YearlyData> yearlyData;
  AssetData({
    required this.year,
    required this.yearlyData,
  });

  AssetData copyWith({
    String? year,
    List<YearlyData>? yearlyData,
  }) {
    return AssetData(
      year: year ?? this.year,
      yearlyData: yearlyData ?? this.yearlyData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'yearlyData': yearlyData.map((x) => x.toMap()).toList(),
    };
  }

  factory AssetData.fromMap(Map<String, dynamic> map) {
    return AssetData(
      year: map['year'] ?? '',
      yearlyData: List<YearlyData>.from(map['yearlyData']?.map((x) => YearlyData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetData.fromJson(String source) => AssetData.fromMap(json.decode(source));

  @override
  String toString() => 'AssetData(year: $year, yearlyData: $yearlyData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetData && other.year == year && listEquals(other.yearlyData, yearlyData);
  }

  @override
  int get hashCode => year.hashCode ^ yearlyData.hashCode;
}
