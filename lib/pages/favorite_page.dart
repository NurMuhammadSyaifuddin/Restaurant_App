import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/model/restaurant.dart';
import 'package:submission_3/providers/favorite_restaurant_provider.dart';
import 'package:submission_3/theme.dart';
import 'package:submission_3/widgets/bottom_nav.dart';
import 'package:submission_3/widgets/restaurant_tile.dart';

import '../widgets/list_skeleton_item.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {
  late Widget listFavoriteRestaurantStream;

  Widget placeHolderWhenLoading() =>
      Column(
        children: const [
          ListSkeletonItem(),
          SizedBox(
            height: 16,
          ),
          ListSkeletonItem(),
          SizedBox(
            height: 16,
          ),
          ListSkeletonItem(),
          SizedBox(
            height: 16,
          ),
          ListSkeletonItem(),
          SizedBox(
            height: 16,
          ),
          ListSkeletonItem(),
          SizedBox(
            height: 16,
          ),
          ListSkeletonItem(),
          SizedBox(
            height: 16,
          )
        ],
      );

  Widget listAllFavoriteRestaurantStream() =>
      ChangeNotifierProvider(
        create: (_) => FavoriteRestaurantProvider(),
        child: Consumer<FavoriteRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultStateFavorite.loading) {
              return placeHolderWhenLoading();
            } else if (state.state == ResultStateFavorite.hasData) {
              List<Restaurant> result = state.result;
              return Column(
                children:
                result.map((e) => RestaurantTile(restaurant: e, isFavoritePage: true)).toList(),
              );
            } else if (state.state == ResultStateFavorite.error) {
              return Center(
                child: Text(
                  state.message,
                  style: blackTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Center(
                child: Text(
                  'No favorite yet',
                  style: blackTextStyle.copyWith(
                      fontSize: 20, fontWeight: semiBold),
                ),
              );
            }
          },
        ),
      );

  @override
  void initState() {
    listFavoriteRestaurantStream = listAllFavoriteRestaurantStream();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Widget content() =>
        RefreshIndicator(
            onRefresh: () async {
              setState(() {
                Provider.of<FavoriteRestaurantProvider>(context, listen: false);

                listFavoriteRestaurantStream =
                    listAllFavoriteRestaurantStream();
              });
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: const EdgeInsets.all(8),
                child: listFavoriteRestaurantStream,
              ),
            ));

    return Scaffold(
      body: SafeArea(
          child: content(),
      ),
      bottomNavigationBar: const BottomNav(selected: TypeBottomNav.favorite),
    );
  }
}
