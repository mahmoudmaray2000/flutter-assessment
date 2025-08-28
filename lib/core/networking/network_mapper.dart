
import 'dart:convert';

abstract class Mappable<T> {
  factory Mappable(Mappable type, dynamic data) {
    if (data is List) {
      if (type is ListMappable) {
        return type.fromJsonList(data) as Mappable<T>;
      }
    } else if (data is String) {
      try {
        final parsedData = jsonDecode(data);
        if (parsedData is List && type is ListMappable) {
          return type.fromJsonList(parsedData) as Mappable<T>;
        } else if (parsedData is Map<String, dynamic> && type is BaseMappable) {
          return type.fromJson(parsedData) as Mappable<T>;
        }
      } catch (e) {
        if (type is BaseMappable) {
          return type.fromJson({'message': 'Invalid response format'}) as Mappable<T>;
        }
      }
    } else if (data is Map<String, dynamic> && type is BaseMappable) {
      return type.fromJson(data) as Mappable<T>;
    }
    if (type is BaseMappable) {
      return type.fromJson({'message': 'Invalid response format'}) as Mappable<T>;
    }
    throw Exception('Unsupported data type or mappable type');
  }
}

abstract class BaseMappable<T> implements Mappable {
  Mappable fromJson(Map<String, dynamic> json);
}

abstract class ListMappable<T> implements Mappable {
  Mappable fromJsonList(List<dynamic> json);
}