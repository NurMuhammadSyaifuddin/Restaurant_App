import 'package:flutter/material.dart';
import 'package:submission_3/model/customer_review.dart';
import 'package:submission_3/theme.dart';

class ReviewTile extends StatelessWidget {
  final CustomerReview review;

  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  padding: const EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(color: whiteColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.person_outline,
                    color: orangeColor,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      review.date ?? '',
                      style: greyTextStyle.copyWith(
                          fontSize: 10, fontWeight: semiBold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ))
              ],
            ),
            const SizedBox(height: 6,),
            Container(
              margin: const EdgeInsets.only(left: 48),
              child: Text(
                "\"${review.review}\"",
                style: blackTextStyle.copyWith(fontSize: 14,
                fontWeight: semiBold),
              ),
            )
          ],
        ),
      );
}
