import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  double? rate;
  double? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = (json['rate'] as num).toDouble();
    count = (json['count'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }

  @override
  List<Object?> get props => [rate, count];
}
