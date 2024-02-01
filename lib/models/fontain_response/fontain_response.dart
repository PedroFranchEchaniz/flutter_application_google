import 'result.dart';

class FontainResponse {
  int? totalCount;
  List<Result>? results;

  FontainResponse({this.totalCount, this.results});

  factory FontainResponse.fromJson(Map<String, dynamic> json) {
    return FontainResponse(
      totalCount: json['total_count'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_count': totalCount,
        'results': results?.map((e) => e.toJson()).toList(),
      };
}
