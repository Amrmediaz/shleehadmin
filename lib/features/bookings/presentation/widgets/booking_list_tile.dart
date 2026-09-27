import 'package:flutter/material.dart';

import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/l10n_extensions.dart';
import '../../data/booking.dart';

class BookingListTile extends StatelessWidget {
  const BookingListTile({super.key, required this.booking, required this.onTap});

  final Booking booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bookingLabel = l10n.bookingNumber(booking.id);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.withOpacity(0.12),
          child: Text(
            booking.name.trim().isNotEmpty ? booking.name.trim()[0].toUpperCase() : '?',
            style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(booking.name.trim().isEmpty ? bookingLabel : booking.name.trim()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(booking.building?.name ?? bookingLabel),
            const SizedBox(height: 2),
            Text('${l10n.daysCount(booking.numberOfDays)} · ${booking.paidAmountLabel}'),
          ],
        ),
        isThreeLine: true,
        trailing: StatusChip(
          label: booking.isPaid ? l10n.paid : l10n.notPaid,
          color: booking.isPaid ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}
