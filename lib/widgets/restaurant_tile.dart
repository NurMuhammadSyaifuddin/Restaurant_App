import 'package:flutter/material.dart';
import 'package:submission_3/model/restaurant.dart';
import 'package:submission_3/theme.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  final bool isFavoritePage;

  const RestaurantTile({super.key, required this.restaurant, required this.isFavoritePage});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/detail_page', arguments: [restaurant, isFavoritePage]);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8.0,
                    offset: const Offset(0, 4))
              ]),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 120,
                    height: 100,
                    child: Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          restaurant.getSmallResolutionPicture(),
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )),
                  )),
              const SizedBox(width: 16,),
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              restaurant.city,
                              style: greyTextStyle.copyWith(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(
                                restaurant.rating.toString(),
                                style: greyTextStyle.copyWith(fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ))
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      );
}
