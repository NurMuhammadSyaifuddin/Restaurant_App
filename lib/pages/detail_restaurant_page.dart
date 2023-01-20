import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:submission_3/model/detail_restaurant.dart';
import 'package:submission_3/model/restaurant.dart';
import 'package:submission_3/services/restaurant_service.dart';
import 'package:submission_3/theme.dart';
import 'package:submission_3/widgets/menu_list_widget.dart';
import 'package:submission_3/widgets/review_tile.dart';

import '../providers/favorite_restaurant_provider.dart';
import '../providers/restaurant_provider.dart';

class DetailRestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  final bool isFavoritePage;

  const DetailRestaurantPage({super.key, required this.restaurant, required this.isFavoritePage});

  @override
  State<StatefulWidget> createState() => _DetailRestaurantPage();
}

class _DetailRestaurantPage extends State<DetailRestaurantPage> {
  bool isExpand = false;
  late RestaurantProvider provider;
  late bool isFavorite;

  Future<bool> checkIsFavoriteRestaurant(String id) async {
    bool result =
        await Provider.of<FavoriteRestaurantProvider>(context, listen: false)
            .getFavoriteRestaurantById(id);

    setState(() {
      isFavorite = result;
    });

    return result;
  }
  
  @override
  void initState() {
    checkIsFavoriteRestaurant(widget.restaurant.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget backButton() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.isFavoritePage){
                  Navigator.pushReplacementNamed(context, '/favorite_page');
                }else {
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 48,
                height: 48,
                margin: const EdgeInsets.all(16),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: whiteColor),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: blackColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  if (isFavorite) {
                    Provider.of<FavoriteRestaurantProvider>(context,
                            listen: false)
                        .deleteFavoriteRestaurant(widget.restaurant);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: redColor,
                        content:
                            const Text('Restaurant removed from favorite')));
                  } else {
                    Provider.of<FavoriteRestaurantProvider>(context,
                            listen: false)
                        .addFavoriteRestaurant(widget.restaurant);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: greenColor,
                        content: const Text('Text added to favorite')));

                  }

                  setState(() {
                    checkIsFavoriteRestaurant(widget.restaurant.id);
                  });

                },
                child: Consumer<FavoriteRestaurantProvider>(
                    builder: (context, state, _) {
                      return Container(
                        width: 48,
                        height: 48,
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: whiteColor),
                        child: Center(
                          child: state.favoriteState == FavoriteState.isFavorite
                              ? Icon(
                            Icons.favorite,
                            color: redColor,
                          )
                              : Icon(
                            Icons.favorite_outline,
                            color: blackColor,
                          ),
                        ),
                      );
                    }),)
          ],
        );

    Widget backgroundImage() => Hero(
        tag: widget.restaurant.pictureId,
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Image.network(
            widget.restaurant.getLargeResolutionPicture(),
            fit: BoxFit.fitHeight,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ));

    Widget content(
            DetailRestaurant detailRestaurant, RestaurantProvider provider) =>
        SizedBox.expand(
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            builder: (context, scrollController) => NotificationListener(
                onNotification: (notif) {
                  if (notif is ScrollEndNotification) {
                    if (notif.metrics.minScrollExtent == -1.0) {
                      setState(() {
                        isExpand = true;
                      });
                    } else {
                      setState(() {
                        isExpand = false;
                      });
                    }
                  }

                  return true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Center(
                                child: Container(
                                  width: 144,
                                  height: 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: backgroundColor),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                detailRestaurant.name,
                                style: blackTextStyle.copyWith(
                                    fontSize: 20, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.red),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        detailRestaurant.city,
                                        style: greyTextStyle.copyWith(
                                            fontSize: 14, fontWeight: semiBold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellowAccent,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        detailRestaurant.rating.toString(),
                                        style: greyTextStyle.copyWith(
                                            fontSize: 14, fontWeight: semiBold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                'Description',
                                style: blackTextStyle.copyWith(
                                    fontSize: 20, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                detailRestaurant.description,
                                style: blackTextStyle.copyWith(
                                    fontSize: 14, fontWeight: light),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                'Foods',
                                style: blackTextStyle.copyWith(
                                    fontSize: 20, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Column(
                                  children: detailRestaurant.menus!.foods
                                      .map((item) => MenuList(
                                          name: item.name,
                                          typeMenu: TypeMenu.foods))
                                      .toList()),
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                'Drinks',
                                style: blackTextStyle.copyWith(
                                    fontSize: 20, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Column(
                                  children: detailRestaurant.menus!.drinks
                                      .map((item) => MenuList(
                                          name: item.name,
                                          typeMenu: TypeMenu.drinks))
                                      .toList()),
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Review Customer',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 20, fontWeight: bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/add_review', arguments: [
                                        widget.restaurant.id,
                                        provider
                                      ]);
                                    },
                                    child: Text(
                                      'Add Review',
                                      style: greyTextStyle.copyWith(
                                          fontSize: 14, fontWeight: semiBold),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              detailRestaurant.customerReviews != null
                                  ? Column(
                                      children: detailRestaurant
                                          .customerReviews!
                                          .map((item) =>
                                              ReviewTile(review: item))
                                          .toList(),
                                    )
                                  : Center(
                                      child: Text(
                                        'There are no reviews yet, be the first to leave a review',
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12, fontWeight: semiBold),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );

    return WillPopScope(onWillPop: () async => false, child: Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          child: ChangeNotifierProvider(
            create: (_) {
              provider = RestaurantProvider(service: RestaurantService());
              return provider.getDetailRestaurant(widget.restaurant.id);
            },
            child: Consumer<RestaurantProvider>(
              builder: ((context, value, _) {
                if (value.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (value.state == ResultState.hashData) {
                  return Stack(
                    children: [
                      backgroundImage(),
                      backButton(),
                      content(value.restaurant.restaurant, value)
                    ],
                  );
                } else if (value.state == ResultState.noData) {
                  return Center(
                    child: Text(
                      value.message,
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        value.message,
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                );
              }),
            ),
          )),
    ));
  }

}
