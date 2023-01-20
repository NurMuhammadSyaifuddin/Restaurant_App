import 'customer_review.dart';

class CustomerReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  CustomerReviewResponse(
      {required this.error,
      required this.message,
      required this.customerReviews});

  factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) =>
      CustomerReviewResponse(
          error: json['error'],
          message: json['message'],
          customerReviews: List<CustomerReview>.from(json['customerReviews']
              .map((item) => CustomerReview.fromJson(item))));
}
