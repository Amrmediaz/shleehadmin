import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../l10n/l10n_extensions.dart';
import '../../payment/presentation/enable_payment_sheet.dart';
import '../cubit/booking_details_cubit.dart';
import '../cubit/booking_details_state.dart';
import '../data/booking.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingDetailsCubit()..load(bookingId),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.bookingNumber(bookingId))),
        body: BlocBuilder<BookingDetailsCubit, BookingDetailsState>(
          builder: (context, state) {
            if (state.status == BookingDetailsStatus.loading) return const LoadingView();
            if (state.status == BookingDetailsStatus.error || state.booking == null) {
              return ErrorView(
                message: state.errorMessage ?? context.l10n.somethingWentWrong,
                onRetry: () => context.read<BookingDetailsCubit>().load(bookingId),
              );
            }
            return _BookingDetailsBody(booking: state.booking!);
          },
        ),
      ),
    );
  }
}

class _BookingDetailsBody extends StatelessWidget {
  const _BookingDetailsBody({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                booking.building?.name ?? l10n.bookingNumber(booking.id),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            StatusChip(
              label: booking.isPaid ? l10n.paid : l10n.notPaid,
              color: booking.isPaid ? Colors.green : Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: l10n.booking,
          rows: [
            _row(l10n.cost, '${booking.cost}'),
            _row(l10n.paid, booking.paidAmountLabel),
            _row(l10n.insurance, booking.insuranceAmount),
            _row(l10n.days, '${booking.numberOfDays}'),
            if (booking.createdDate != null) _row(l10n.created, booking.createdDate!.toLocal().toString()),
            if (booking.note != null && booking.note!.trim().isNotEmpty) _row(l10n.note, booking.note!),
          ],
        ),
        if (booking.bookingDays.isNotEmpty) ...[
          const SizedBox(height: 12),
          _SectionCard(
            title: l10n.bookedDays,
            rows: booking.bookingDays
                .map((d) => _row(d.day, d.isFullDay ? l10n.fullDay : l10n.halfDay))
                .toList(),
          ),
        ],
        const SizedBox(height: 12),
        _SectionCard(
          title: l10n.customer,
          rows: [
            _row(l10n.name, booking.customer?.fullName ?? booking.name),
            _row(l10n.phone, booking.customer?.phoneNumber ?? booking.phone),
            if (booking.customer?.email.isNotEmpty == true) _row(l10n.email, booking.customer!.email),
          ],
        ),
        if (booking.building != null) ...[
          const SizedBox(height: 12),
          _SectionCard(
            title: l10n.chalet,
            rows: [
              _row(l10n.name, booking.building!.name),
              _row(l10n.type, booking.building!.chaletType),
              if (booking.building!.location.isNotEmpty) _row(l10n.location, booking.building!.location),
              if (booking.building!.capacity != null) _row(l10n.capacity, booking.building!.capacity!),
              if (booking.building!.rentFullday != null) _row(l10n.fullDayRate, booking.building!.rentFullday!),
            ],
          ),
        ],
        const SizedBox(height: 24),
        if (!booking.isPaid)
          FilledButton.icon(
            icon: const Icon(Icons.payments_outlined),
            label: Text(l10n.enablePayment),
            style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
            onPressed: () async {
              final enabled = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                builder: (_) => EnablePaymentSheet(bookingId: booking.id),
              );
              if (enabled == true && context.mounted) {
                context.read<BookingDetailsCubit>().load(booking.id);
              }
            },
          ),
      ],
    );
  }

  Widget _row(String label, String value) => _KeyValueRow(label: label, value: value);
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.rows});

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ...rows,
          ],
        ),
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: TextStyle(color: Colors.grey.shade600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
