import 'package:equatable/equatable.dart';

enum PaymentStatus { idle, submitting, success, error, unauthorized }

class PaymentState extends Equatable {
  final PaymentStatus status;
  final String? errorMessage;

  const PaymentState._({required this.status, this.errorMessage});

  const PaymentState.idle() : this._(status: PaymentStatus.idle);

  const PaymentState.submitting() : this._(status: PaymentStatus.submitting);

  const PaymentState.success() : this._(status: PaymentStatus.success);

  const PaymentState.error(String message)
      : this._(status: PaymentStatus.error, errorMessage: message);

  const PaymentState.unauthorized()
      : this._(status: PaymentStatus.unauthorized);

  bool get isSubmitting => status == PaymentStatus.submitting;

  @override
  List<Object?> get props => [status, errorMessage];
}
