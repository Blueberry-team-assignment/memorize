// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeckImpl _$$DeckImplFromJson(Map<String, dynamic> json) => _$DeckImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$$DeckImplToJson(_$DeckImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
    };
