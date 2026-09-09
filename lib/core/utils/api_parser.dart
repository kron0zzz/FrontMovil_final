import 'dart:convert';

/// Clase genérica para respuestas paginadas de la API
class PaginatedResponse<T> {
  final List<T> data;
  final PaginationInfo pagination;

  PaginatedResponse({
    required this.data,
    required this.pagination,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final List<dynamic> dataList = json['data'] as List<dynamic>? ?? [];
    final data = dataList.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    
    final paginationJson = json['pagination'] as Map<String, dynamic>? ?? {};
    final pagination = PaginationInfo.fromJson(paginationJson);
    
    return PaginatedResponse(data: data, pagination: pagination);
  }
}

/// Información de paginación
class PaginationInfo {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  PaginationInfo({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 1,
    );
  }

  /// Crea una copia con página actualizada
  PaginationInfo copyWith({
    int? page,
    int? limit,
    int? total,
    int? totalPages,
  }) {
    return PaginationInfo(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  bool get hasNextPage => page < totalPages;
  bool get hasPreviousPage => page > 1;
}

/// Parser genérico para extraer lista de items de respuestas legacy (sin paginación)
List<T> parseLegacyList<T>(
  dynamic response,
  T Function(Map<String, dynamic>) fromJson, {
  List<String> dataKeys = const ['data', 'rows', 'items', 'result', 'machines', 'projects', 'orders', 'customers', 'machinery'],
}) {
  if (response == null) return [];
  
  dynamic rawList;
  
  if (response is List) {
    rawList = response;
  } else if (response is Map<String, dynamic>) {
    // Primero intenta 'data'
    if (response.containsKey('data')) {
      rawList = response['data'];
      // Si data es un mapa, busca claves comunes dentro
      if (rawList is Map<String, dynamic>) {
        for (final key in dataKeys) {
          if (rawList.containsKey(key) && rawList[key] is List) {
            rawList = rawList[key];
            break;
          }
        }
      }
    }
    
    // Si no se encontró en data, busca en la raíz
    if (rawList == null || rawList is! List) {
      for (final key in dataKeys) {
        if (response.containsKey(key) && response[key] is List) {
          rawList = response[key];
          break;
        }
      }
    }
  }
  
  if (rawList is List) {
    return rawList.map<T>((e) {
      final map = e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map);
      return fromJson(map);
    }).toList();
  }
  
  return [];
}

/// Detecta si la respuesta tiene estructura paginada
bool isPaginatedResponse(dynamic response) {
  if (response is Map<String, dynamic>) {
    return response.containsKey('data') && response.containsKey('pagination');
  }
  return false;
}