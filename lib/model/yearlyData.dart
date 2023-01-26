import 'dart:convert';

class YearlyData {
  final int id;
  final String sector;
  final String assetName;
  final double assetValue;
  final String year;
  final String symbol;
  YearlyData({
    required this.id,
    required this.sector,
    required this.assetName,
    required this.assetValue,
    required this.year,
    required this.symbol,
  });

  YearlyData copyWith({
    int? id,
    String? sector,
    String? assetName,
    double? assetValue,
    String? year,
    String? symbol,
  }) {
    return YearlyData(
      id: id ?? this.id,
      sector: sector ?? this.sector,
      assetName: assetName ?? this.assetName,
      assetValue: assetValue ?? this.assetValue,
      year: year ?? this.year,
      symbol: symbol ?? this.symbol,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sector': sector,
      'asset_name': assetName,
      'asset_value': assetValue,
      'year': year,
      'symbol': symbol,
    };
  }

  factory YearlyData.fromMap(Map<String, dynamic> map) {
    return YearlyData(
      id: map['id']?.toInt() ?? 0,
      sector: map['sector'] ?? '',
      assetName: map['asset_name'] ?? '',
      assetValue: map['asset_value']?.toDouble() ?? 0.0,
      year: map['year'] ?? '',
      symbol: map['symbol'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory YearlyData.fromJson(String source) => YearlyData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'YearlyData(id: $id, sector: $sector, assetName: $assetName, assetValue: $assetValue, year: $year, symbol: $symbol)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YearlyData && other.id == id && other.sector == sector && other.assetName == assetName && other.assetValue == assetValue && other.year == year && other.symbol == symbol;
  }

  @override
  int get hashCode {
    return id.hashCode ^ sector.hashCode ^ assetName.hashCode ^ assetValue.hashCode ^ year.hashCode ^ symbol.hashCode;
  }
}
