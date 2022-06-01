import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/blocs/add_new_post_bloc.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/viewitems/news_feed_item_view.dart';

class AddNewPostPage extends StatelessWidget {
  const AddNewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddNewPostBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: MARGIN_XLARGE,
              )),
          title: const Text("Add New Post",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_HEADING_1X)),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            // margin: const EdgeInsets.only(top: MARGIN_XLARGE),
            padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_LARGE, vertical: MARGIN_XLARGE),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ProfileImageAndNameView(),
                SizedBox(
                  height: MARGIN_MEDIUM_3,
                ),
                AddNewPostTextFieldView(),
                // MaterialButton(onPressed: () {},color: Colors.black,child: Text("Post",style: TextStyle(color: Colors.white),)),
                SizedBox(
                  height: MARGIN_MEDIUM_3,
                ),
                PostDescriptionErrorView(),
                SizedBox(
                  height: MARGIN_MEDIUM_3,
                ),
                PostButtonView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostDescriptionErrorView extends StatelessWidget {
  const PostDescriptionErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (BuildContext context, bloc, Widget? child) {
        return Visibility(
          visible: bloc.isAddNewPostError,
          child: const Text(
            "Post shouldn't be empty",
            style: TextStyle(
                color: Colors.red,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }
}

class PostButtonView extends StatelessWidget {
  const PostButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (BuildContext context, bloc, Widget? child) {
        return GestureDetector(
          onTap: () {
            bloc.onTapAddNewPost().then((value) {
              Navigator.pop(context);
            });
          },
          child: Container(
            width: double.infinity,
            height: MARGIN_XXLARGE,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(MARGIN_LARGE),
            ),
            child: const Center(
              child: Text(
                "Post",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddNewPostTextFieldView extends StatelessWidget {
  const AddNewPostTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (BuildContext context, bloc, Widget? child) {
        return SizedBox(
          height: 300,
          child: TextField(
            maxLines: 24,
            onChanged: (text) {
              bloc.onNewPostTextChanged(text);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                borderSide: const BorderSide(width: 1, color: Colors.grey),
              ),
              hintText: "What's in your mind?",
            ),
          ),
        );
      },
    );
  }
}

class ProfileImageAndNameView extends StatelessWidget {
  const ProfileImageAndNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileImageView(
            profileImage:
                "https://scontent-sin6-4.xx.fbcdn.net/v/t1.6435-9/91521846_730904297681781_7767512976893935616_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=OwDQxt9BVzsAX_3l0Cx&_nc_ht=scontent-sin6-4.xx&oh=00_AT8wDx_uQmzwhDyRStvBFq0TygYI-oFmqDOyMb9e_MPlCg&oe=62BC328A"),
        const SizedBox(
          width: MARGIN_MEDIUM_3,
        ),
        const Text(
          "Pyi Theim Kyaw",
          style: const TextStyle(
              fontSize: TEXT_REGULAR_2X, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
