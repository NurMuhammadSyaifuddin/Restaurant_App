import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:submission_3/theme.dart';

class ListSkeletonItem extends StatelessWidget {
  const ListSkeletonItem({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15,
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
                child: Shimmer.fromColors(
                    baseColor: backgroundColor,
                    highlightColor: greyColor,
                    child: Container(
                      width: 120,
                      height: 100,
                      color: backgroundColor,
                    ))),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                        baseColor: backgroundColor,
                        highlightColor: greyColor,
                        child: Container(
                          height: 16,
                          color: backgroundColor,
                        )),
                    const SizedBox(
                      height: 6,
                    ),
                    Shimmer.fromColors(
                        baseColor: backgroundColor,
                        highlightColor: greyColor,
                        child: Container(
                          width: 48,
                          height: 12,
                          color: backgroundColor,
                        ))
                  ],
                ))
          ],
        ),
      );
}
