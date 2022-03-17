import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dictionary.g.dart';

/// A dictionary that can be imported into the application. Dictionary details
/// are stored in a database, while this separate class is used to encapsulate
/// and represent the metadata of the dictionary.
@JsonSerializable()
@Collection()
class Dictionary {
  /// Initialise a dictionary with details from import.
  Dictionary({
    required this.dictionaryName,
    required this.formatName,
    required this.metadataJson,
  });

  /// Create an instance of this class from a serialized format.
  factory Dictionary.fromJson(Map<String, dynamic> json) =>
      _$DictionaryFromJson(json);

  /// Convert this into a serialized format.
  Map<String, dynamic> toJson() => _$DictionaryToJson(this);

  /// A unique identifier for the purposes of database storage.
  @Id()
  int? id;

  /// The name of the dictionary. For example, this could be "Merriam-Webster
  /// Dictionary" or "大辞林" or "JMdict".
  ///
  /// Dictionary names are meant to be unique, meaning two dictionaries of the
  /// same name should not be allowed to be added in the database. The
  /// database will also effectively use this dictionary name as a directory
  /// prefix.
  final String dictionaryName;

  /// The format that the dictionary was sourced from.
  final String formatName;

  /// The serialized metadata of this dictionary.
  final String metadataJson;

  /// Get the metadata pertaining to this dictionary from import. Used for
  /// format-specific enhancements.
  Map<String, dynamic> get metadata {
    _metadata ??= jsonDecode(metadataJson);
    return _metadata!;
  }

  late final Map<String, dynamic>? _metadata;
}
