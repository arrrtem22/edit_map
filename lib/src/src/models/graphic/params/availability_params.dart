import 'package:equatable/equatable.dart';

class AvailabilityParams extends Equatable {
  final bool isBooked;

  const AvailabilityParams({this.isBooked = false});

  @override
  List<Object?> get props => [isBooked];
}
