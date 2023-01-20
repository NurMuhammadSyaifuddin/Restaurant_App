class CustomerReview {
  final String? id;
  final String name;
  final String review;
  final String? date;

  CustomerReview(
      {this.id = '', required this.name, required this.review, this.date = ''});

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
      id: json['id'],
      name: json['name'],
      review: json['review'],
      date: json['date']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'review': review, 'date': date};
}
