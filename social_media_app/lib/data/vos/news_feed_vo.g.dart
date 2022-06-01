// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_feed_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsFeedVO _$NewsFeedVOFromJson(Map<String, dynamic> json) => NewsFeedVO(
      json['id'] as int?,
      json['description'] as String?,
      json['post_image'] as String?,
      json['profile_picture'] as String?,
      json['user_name'] as String?,
    );

Map<String, dynamic> _$NewsFeedVOToJson(NewsFeedVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'post_image': instance.postImage,
      'profile_picture': instance.profilePicture,
      'user_name': instance.userName,
    };
