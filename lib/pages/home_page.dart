import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/model/restaurant.dart';
import 'package:submission_3/providers/restaurant_provider.dart';
import 'package:submission_3/services/restaurant_service.dart';
import 'package:submission_3/theme.dart';
import 'package:submission_3/utils/notification_helper.dart';
import 'package:submission_3/widgets/bottom_nav.dart';
import 'package:submission_3/widgets/list_skeleton_item.dart';
import 'package:submission_3/widgets/restaurant_tile.dart';

import '../widgets/search_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final searchController = TextEditingController(text: '');
  Widget listRestaurantStream = Container();

  Widget placeHolderWhenLoading() => Column(
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

  Widget listSearchRestaurant(String query) =>
      Consumer<RestaurantProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return placeHolderWhenLoading();
        } else if (state.state == ResultState.hashData) {
          if (query == '') {
            List<Restaurant> result = state.restaurants.restaurants;

            return Column(
              children: result
                  .map((item) => RestaurantTile(restaurant: item, isFavoritePage: false))
                  .toList(),
            );
          }

          List<Restaurant> resultSearch = state.searchRestaurant.restaurants;
          return Column(
            children: resultSearch
                .map((item) => RestaurantTile(restaurant: item, isFavoritePage: false,))
                .toList(),
          );
        } else if (state.state == ResultState.error) {
          return Column(
            children: [
              const Icon(
                Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
                size: 120,
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  state.message,
                  style:
                      blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          );
        }

        return Center(
          child: Text(
            'The restaurant is not currently available',
            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            textAlign: TextAlign.center,
          ),
        );
      });

  Widget listAllRestaurantStream() => ChangeNotifierProvider(
      create: (_) =>
          RestaurantProvider(service: RestaurantService()).getRestaurants(''),
      child: listSearchRestaurant(''));

  @override
  void initState() {
    super.initState();
    listRestaurantStream = listAllRestaurantStream();
    NotificationHelper.configureSelectNotificationSubject('/detail_page');
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(child: content()),
        bottomNavigationBar: const BottomNav(selected: TypeBottomNav.home),
      );

  Widget headerContent() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/profile.png',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Welcome Back Sir!',
                  style: blackTextStyle.copyWith(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'The restaurant you are looking for is here',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 32,
            ),
            SearchTile(
                searchController: searchController,
                hint: 'Find your favorite restaurant',
                onChange: (value) {
                  setState(() {
                    Provider.of<RestaurantProvider>(context, listen: false)
                        .getRestaurants(value);

                    listRestaurantStream = listSearchRestaurant(value);
                  });
                }),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      );

  Widget content() => RefreshIndicator(
      onRefresh: () async {
        setState(() {
          searchController.text = '';
          Provider.of<RestaurantProvider>(context, listen: false)
              .getRestaurants('');

          listRestaurantStream = listSearchRestaurant('');
        });
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [headerContent(), listRestaurantStream],
          ),
        ),
      ));
}
