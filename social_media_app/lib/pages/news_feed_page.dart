import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/blocs/news_feed_bloc.dart';
import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/model/social_model_impl.dart';
import 'package:social_media_app/pages/add_new_post_page.dart';
import 'package:social_media_app/pages/login_page.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/utils/extensions.dart';
import 'package:social_media_app/viewitems/news_feed_item_view.dart';

class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialModel mSocialModel = SocialModelImpl();
    return ChangeNotifierProvider(
      create: (BuildContext context) => NewsFeedBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToNextScreen(context, AddNewPostPage());
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Container(
            margin: const EdgeInsets.only(
              left: MARGIN_MEDIUM,
            ),
            child: const Text(
              "Social",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TEXT_HEADING_1X,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                /// TODO : - Handle Search Here
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: MARGIN_LARGE,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: MARGIN_LARGE,
                ),
              ),
            ),
            Consumer<NewsFeedBloc>(
              builder: (BuildContext context, bloc, Widget? child) {
                return GestureDetector(
                  onTap: () {
                    bloc.onTapLogOut().then((value) {
                      navigateToNextScreen(context, const LoginPage());
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.only(
                        right: MARGIN_LARGE,
                      ),
                      child: const Icon(
                        Icons.login_outlined,
                        color: Colors.red,
                      )),
                );
              },
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Consumer<NewsFeedBloc>(
            builder: (BuildContext context, bloc, Widget? child) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: MARGIN_LARGE,
                  horizontal: MARGIN_LARGE,
                ),
                itemBuilder: (context, index) {
                  return NewsFeedItemView(
                    newsFeedItem: bloc.newsFeed?[index],
                    onTapDelete: (postId) {
                      bloc.onTapDelete(postId);
                    },
                    onTapEdit: (newsFeedId) {
                      Future.delayed(const Duration(seconds: 1)).then((value) {
                        navigateToNextScreen(
                            context, AddNewPostPage(newsFeedId: newsFeedId));
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: MARGIN_XLARGE,
                  );
                },
                itemCount: bloc.newsFeed?.length ?? 0,
              );
            },
          ),
        ),
      ),
    );
  }
}
