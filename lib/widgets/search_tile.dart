import 'package:flutter/material.dart';
import 'package:submission_3/theme.dart';

class SearchTile extends StatelessWidget {
  final TextEditingController searchController;
  final String hint;
  final Function(String) onChange;

  const SearchTile({super.key, required this.searchController, required this.hint, required this.onChange});

  @override
  Widget build(BuildContext context) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow:[
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8.0,
              offset:const Offset(0, 4)
            )
          ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, color: blackColor, size: 20,),
            const SizedBox(width: 10,),
            Expanded(child: TextFormField(
              controller: searchController,
              decoration: InputDecoration.collapsed(hintText: hint,
              hintStyle: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
              onChanged: onChange,
              onFieldSubmitted: onChange,
            ))
          ],
        ),
      );

}