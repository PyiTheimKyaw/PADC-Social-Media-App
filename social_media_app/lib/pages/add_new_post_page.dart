import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/blocs/add_new_post_bloc.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/viewitems/news_feed_item_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AddNewPostPage extends StatelessWidget {
  AddNewPostPage({Key? key, this.newsFeedId}) : super(key: key);
  int? newsFeedId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddNewPostBloc(newsFeedId: newsFeedId),
      child: Selector<AddNewPostBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        shouldRebuild: (previous, next) => previous != next,
        builder: (BuildContext context, isLoading, Widget? child) {
          return Stack(
            children: [
              Scaffold(
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
                        Expanded(child: AddNewPostTextFieldView()),
                        // MaterialButton(onPressed: () {},color: Colors.black,child: Text("Post",style: TextStyle(color: Colors.white),)),
                        SizedBox(
                          height: MARGIN_MEDIUM_3,
                        ),
                        PostDescriptionErrorView(),
                        SizedBox(
                          height: MARGIN_MEDIUM_3,
                        ),
                        Expanded(child: PostImageView()),
                        SizedBox(
                          height: MARGIN_MEDIUM_3,
                        ),
                        PostButtonView(),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: isLoading,
                  child: Container(
                    color: Colors.black12,
                    child: const Center(
                      child: LoadingView(),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: MARGIN_XXLARGE,
      height: MARGIN_XXLARGE,
      child: LoadingIndicator(
        indicatorType: Indicator.audioEqualizer,
        colors: [Colors.white],
        strokeWidth: 2,
        backgroundColor: Colors.transparent,
        pathBackgroundColor: Colors.black,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  const PostImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (BuildContext context, bloc, Widget? child) {
        return Container(
          padding: EdgeInsets.all(MARGIN_MEDIUM),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Stack(
            children: [
              Container(
                child: Center(
                  child: (bloc.isInEditMode && bloc.image !="")
                      ? SizedBox(
                          height: 300,
                          child: Image.network(
                            bloc.image ?? "",
                            fit: BoxFit.cover,
                          ),
                        )
                      : (bloc.chosenImageFile == null && bloc.image =="")
                          ? GestureDetector(
                              onTap: () async {
                                final ImagePicker _picker = ImagePicker();
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  bloc.onImageChosen(File(image.path));
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: Image.network(
                                  "https://pooldues.com/wp-content/uploads/2018/04/image-upload-placeholder.jpg",
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 300,
                              child: Image.file(
                                bloc.chosenImageFile ?? File(""),
                                fit: BoxFit.cover,
                              ),
                            ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: (bloc.chosenImageFile != null || bloc.image !=""),
                  child: GestureDetector(
                    onTap: () {
                      bloc.onTapDeleteImage();
                    },
                    child: const Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
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
            autofocus: false,
            maxLines: 24,
            controller: TextEditingController(text: bloc.newPostDescription),
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
    return Consumer<AddNewPostBloc>(
      builder: (BuildContext context, bloc, Widget? child) {
        return Row(
          children: [
            ProfileImageView(profileImage: bloc.profilePicture),
            const SizedBox(
              width: MARGIN_MEDIUM_3,
            ),
            Text(
              bloc.userName ?? "",
              style: const TextStyle(
                  fontSize: TEXT_REGULAR_2X, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
