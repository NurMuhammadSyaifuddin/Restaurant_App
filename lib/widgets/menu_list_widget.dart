import 'package:flutter/material.dart';
import 'package:submission_3/theme.dart';

enum TypeMenu { foods, drinks }

class MenuList extends StatelessWidget {
  final String name;
  final TypeMenu typeMenu;

  const MenuList({super.key, required this.name, required this.typeMenu});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            typeMenu == TypeMenu.foods
                ? const Icon(
                    Icons.rice_bowl,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.coffee,
                    color: Colors.grey,
                  ),
            Text(
              name,
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: light),
            )
          ],
        ),
      );
}
