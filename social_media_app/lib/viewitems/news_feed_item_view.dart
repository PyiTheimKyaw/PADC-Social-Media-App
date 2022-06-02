import 'package:flutter/material.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/resources/images.dart';

class NewsFeedItemView extends StatelessWidget {
  const NewsFeedItemView({
    Key? key,
    required this.newsFeedItem,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);
  final NewsFeedVO? newsFeedItem;
  final Function(int) onTapDelete;
  final Function(int) onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ProfileImageView(
              profileImage: newsFeedItem?.profilePicture,
            ),
            const SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            NameLocationAndTimeAgoView(
              name: newsFeedItem?.userName,
            ),
            const Spacer(),
            MoreButtonView(
              onTapDelete: () {
                onTapDelete(newsFeedItem?.id ?? 0);
              },
              onTapEdit: () {
                onTapEdit(newsFeedItem?.id ?? 0);
              },
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        PostImageView(
          postImage: newsFeedItem?.postImage,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        PostDescriptionView(
          description: newsFeedItem?.description,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: const [
            Text(
              "See Comments",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Icon(
              Icons.mode_comment_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.grey,
            )
          ],
        )
      ],
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  PostDescriptionView({
    Key? key,
    required this.description,
  }) : super(key: key);
  String? description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description ?? "",
      style: const TextStyle(
        fontSize: TEXT_REGULAR,
        color: Colors.black,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  PostImageView({required this.postImage});

  String? postImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
      child: FadeInImage(
        height: 200,
        width: double.infinity,
        placeholder: const NetworkImage(
          NETWORK_IMAGE_POST_PLACEHOLDER,
        ),
        image: NetworkImage(
          postImage ?? "",
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  const MoreButtonView({
    Key? key,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);
  final Function onTapDelete;
  final Function onTapEdit;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Text("Edit"),
          value: 1,
          onTap: () {
            onTapEdit();
          },
        ),
        PopupMenuItem(
          child: const Text("Delete"),
          value: 2,
          onTap: () {
            onTapDelete();
          },
        ),
      ],
      child: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ),
    );
  }
}

class ProfileImageView extends StatelessWidget {
  ProfileImageView({required this.profileImage});

  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        profileImage ?? "",
      ),
      radius: MARGIN_LARGE,
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {
  NameLocationAndTimeAgoView({
    Key? key,
    required this.name,
  }) : super(key: key);
  String? name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name ?? "",
              style: const TextStyle(
                fontSize: TEXT_REGULAR_2X,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: MARGIN_SMALL,
            ),
            const Text(
              "- 2 hours ago",
              style:  TextStyle(
                fontSize: TEXT_SMALL,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        const Text(
          "Paris",
          style: TextStyle(
            fontSize: TEXT_SMALL,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
