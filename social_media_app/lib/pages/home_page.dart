import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/blocs/news_feed_bloc.dart';
import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/model/social_model_impl.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/viewitems/news_feed_item_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SocialModel mSocialModel=SocialModelImpl();
  @override
  void initState() {
    // TODO: implement initState
    mSocialModel.getNewsFeed().listen((event) {
      print("List of data => ${event.toString()}");
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NewsFeedBloc(),
      child: Scaffold(
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
                  return  NewsFeedItemView(
                    newsFeedItem: bloc.newsFeed?[index],
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
