import 'geometry.dart';
import 'properties.dart';

class GeoShape {
  String? type;
  Geometry? geometry;
  Properties? properties;

  GeoShape({this.type, this.geometry, this.properties});

  factory GeoShape.fromJson(Map<String, dynamic> json) => GeoShape(
        type: json['type'] as String?,
        geometry: json['geometry'] == null
            ? null
            : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
        properties: json['properties'] == null
            ? null
            : Properties.fromJson(json['properties'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'geometry': geometry?.toJson(),
        'properties': properties?.toJson(),
      };
}
