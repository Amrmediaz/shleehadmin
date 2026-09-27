import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n_extensions.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/presentation/login_screen.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';
import '../data/payment_repository.dart';

/// Bottom sheet used from BookingDetailsScreen to trigger
/// POST /AppOwner/OutPayment for a specific booking.
class EnablePaymentSheet extends StatefulWidget {
  const EnablePaymentSheet({super.key, required this.bookingId});

  final int bookingId;

  @override
  State<EnablePaymentSheet> createState() => _EnablePaymentSheetState();
}

class _EnablePaymentSheetState extends State<EnablePaymentSheet> {
  PaymentType _selectedType = PaymentType.type1;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.status == PaymentStatus.success) {
            Navigator.of(context).pop(true);
          } else if (state.status == PaymentStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? l10n.somethingWentWrong)),
            );
          } else if (state.status == PaymentStatus.unauthorized) {
            Navigator.of(context).pop(false);
            context.read<AuthCubit>().logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  l10n.enablePaymentForBooking(widget.bookingId),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<PaymentType>(
                  value: _selectedType,
                  decoration: InputDecoration(
                    labelText: l10n.paymentType,
                    border: const OutlineInputBorder(),
                  ),
                  items: PaymentType.values
                      .map((type) => DropdownMenuItem(value: type, child: Text(type.label(context))))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _selectedType = value);
                  },
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.read<PaymentCubit>().enableBookingPayment(
                            bookingId: widget.bookingId,
                            paymentType: _selectedType.value,
                          ),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: state.isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l10n.confirm),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
