import 'package:flutter/material.dart';
import 'package:submission_3/model/customer_review.dart';
import 'package:submission_3/providers/restaurant_provider.dart';
import 'package:submission_3/theme.dart';

import '../widgets/general_button.dart';

class AddReviewPage extends StatefulWidget {
  final String idRestaurant;
  final RestaurantProvider provider;

  const AddReviewPage(
      {super.key, required this.idRestaurant, required this.provider});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _reviewController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AppBar header() => AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Add New Review',
          style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 18),
        ));

    Widget inputUser(
            {required String hint,
            required TextEditingController controller}) =>
        Container(
          margin: const EdgeInsets.only(top: 24, left: 8, right: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8.0,
                    offset: const Offset(0, 4))
              ]),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle:
                    greyTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)),
          ),
        );

    Widget submitButton() => GestureDetector(
          onTap: () async {
            CustomerReview customerReview = CustomerReview(
                id: widget.idRestaurant,
                name: _nameController.text,
                review: _reviewController.text);
            widget.provider.addReview(customerReview).then((value) =>
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Review added succesfully'))));
            Navigator.pop(context);
          },
          child: GeneralButton(
            text: 'Add Review',
            backgroundColor: primaryColor,
            textColor: whiteColor,
            width: double.infinity,
            borderRadius: 8,
            height: 48,
            fontSize: 16,
          ),
        );

    Widget content() => Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                inputUser(hint: 'Your name', controller: _nameController),
                inputUser(hint: 'Write a review', controller: _reviewController),
                submitButton()
              ],
            ),
          ),
        );

    return Scaffold(appBar: header(), body: SafeArea(child: content()));
  }
}
