import 'geo_point2d.dart';
import 'geo_shape.dart';

class Result {
  int? objectid;
  String? calle;
  String? codigo;
  String? foto;
  GeoShape? geoShape;
  GeoPoint2d? geoPoint2d;

  Result({
    this.objectid,
    this.calle,
    this.codigo,
    this.foto,
    this.geoShape,
    this.geoPoint2d,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        objectid: json['objectid'] as int?,
        calle: json['calle'] as String?,
        codigo: json['codigo'] as String?,
        foto: json['foto'] as String?,
        geoShape: json['geo_shape'] == null
            ? null
            : GeoShape.fromJson(json['geo_shape'] as Map<String, dynamic>),
        geoPoint2d: json['geo_point_2d'] == null
            ? null
            : GeoPoint2d.fromJson(json['geo_point_2d'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'objectid': objectid,
        'calle': calle,
        'codigo': codigo,
        'foto': foto,
        'geo_shape': geoShape?.toJson(),
        'geo_point_2d': geoPoint2d?.toJson(),
      };
}
