class GeoPoint2d {
  double? lon;
  double? lat;

  GeoPoint2d({this.lon, this.lat});

  factory GeoPoint2d.fromJson(Map<String, dynamic> json) => GeoPoint2d(
        lon: (json['lon'] as num?)?.toDouble(),
        lat: (json['lat'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}
