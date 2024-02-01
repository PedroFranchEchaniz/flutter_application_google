class Geometry {
  List<dynamic>? coordinates;
  String? type;

  Geometry({this.coordinates, this.type});

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json['coordinates'] as List<double>?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'coordinates': coordinates,
        'type': type,
      };
}
