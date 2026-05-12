import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Design Tokens (Figma variables) ─────────────────────────────────────────

abstract final class AppColors {
  /// Primary blue — used for header background, icon boxes, badges, primary button
  static const primary = Color(0xFF155DFC);

  /// White — Figma variable "White"
  static const white = Color(0xFFFFFFFF);

  /// Grey 2 — Figma variable "Grey 2", used for borders and secondary button
  static const grey2 = Color(0xFFE5E7EB);

  /// Black — Figma variable "Black"
  static const black = Color(0xFF364153);

  static const grey50 = Color(0xFFF9FAFB);
  static const grey100 = Color(0xFFF3F4F6);
  static const textDark = Color(0xFF101828);
  static const textMedium = Color(0xFF4A5565);
  static const textSecondary = Color(0xFF364153);
  static const textMuted = Color(0xFF6A7282);
  static const lightBlue = Color(0xFFDBEAFE);
  static const lightBlueAlt = Color(0xFFEFF6FF);
}

abstract final class AppTextStyles {
  /// Heading One — Inter SemiBold, fontSize: Text size/Extra Large (20px)
  static TextStyle get headingOne => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        height: 1.4,
        letterSpacing: -0.449,
        color: AppColors.white,
      );

  /// Heading Two — Inter SemiBold, fontSize: Text size/Large (18px)
  static TextStyle get headingTwo => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        height: 1.5,
        letterSpacing: -0.439,
        color: AppColors.textDark,
      );

  /// Heading Three — Inter SemiBold, fontSize: 16px
  static TextStyle get headingThree => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.5,
        letterSpacing: -0.313,
        color: AppColors.textDark,
      );
}

// ─── Local Assets ─────────────────────────────────────────────────────────────

abstract final class _Assets {
  static const iconConfirmed  = 'assets/icons/icon_confirmed.svg';
  static const iconPhone      = 'assets/icons/icon_phone.svg';
  static const doctorPhoto    = 'assets/images/doctor_photo.jpg';
  static const iconCalendar   = 'assets/icons/icon_calendar.svg';
  static const iconClock      = 'assets/icons/icon_clock.svg';
  static const iconLocation   = 'assets/icons/icon_location.svg';
  static const iconClipboard  = 'assets/icons/icon_clipboard.svg';
  static const iconCheck      = 'assets/icons/icon_check.svg';
  static const iconDirections = 'assets/icons/icon_directions.svg';
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class AppointmentCardScreen extends StatelessWidget {
  const AppointmentCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Stack: blue header with the details card floating/overlapping it by 64px.
              // clipBehavior.none lets the card render below the header's layout boundary.
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const _AppointmentHeader(),
                  Positioned(
                    top: 184,
                    left: 16,
                    right: 16,
                    child: _AppointmentDetailsCard(),
                  ),
                ],
              ),
              // Compensate for the card overhanging below the Stack:
              // card bottom = 184 + 280.5 = 464.5, stack bottom = 248, diff = 216.5 + 16 gap
              const SizedBox(height: 233),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _PrepareSection(),
              ),
              const SizedBox(height: 16),
              const _ActionButtons(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _AppointmentHeader extends StatelessWidget {
  const _AppointmentHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 248,
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // Confirmed status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(_Assets.iconConfirmed,
                        width: 16, height: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Confirmed',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.150,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Phone icon button
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(_Assets.iconPhone, fit: BoxFit.contain),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Doctor profile row
          Row(
            children: [
              // Avatar card
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 7.5,
                      offset: Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 3,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    color: AppColors.lightBlueAlt,
                    child: Image.asset(
                      _Assets.doctorPhoto,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Dr. Sarah Mitchell',
                        style: AppTextStyles.headingOne),
                    const SizedBox(height: 2),
                    Text(
                      'Cardiologist',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: -0.150,
                        color: AppColors.lightBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Appointment Details Card ─────────────────────────────────────────────────

class _AppointmentDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 20,
            offset: Offset(0, 20),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12.5,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _DetailRow(
            iconUrl: _Assets.iconCalendar,
            label: 'DATE & TIME',
            showDivider: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monday, May 12, 2026',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: -0.313,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    SvgPicture.asset(_Assets.iconClock, width: 14, height: 14),
                    const SizedBox(width: 4),
                    Text(
                      '10:30 AM - 11:00 AM',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: -0.150,
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _DetailRow(
            iconUrl: _Assets.iconLocation,
            label: 'LOCATION',
            showDivider: true,
            child: Text(
              'Heart & Wellness Center, 456 Medical Plaza, Bristol.',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.375,
                letterSpacing: -0.150,
                color: AppColors.textDark,
              ),
            ),
          ),
          _DetailRow(
            iconUrl: _Assets.iconClipboard,
            label: 'VISIT TYPE',
            showDivider: false,
            child: Text(
              'Follow-up Consultation',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                letterSpacing: -0.313,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.iconUrl,
    required this.label,
    required this.child,
    required this.showDivider,
  });

  final String iconUrl;
  final String label;
  final Widget child;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(21, 21, 21, 17),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.grey100),
              ),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blue icon box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 3,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(iconUrl, width: 24, height: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    letterSpacing: 0.3,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Prepare Section ──────────────────────────────────────────────────────────

class _PrepareSection extends StatelessWidget {
  static const _items = [
    'Bring your NHS number',
    'Arrive 15 minutes early',
    'Bring questions or symptoms to discuss',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Prepare for your visit', style: AppTextStyles.headingTwo),
          const SizedBox(height: 12),
          for (final item in _items) _CheckItem(text: item),
        ],
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  const _CheckItem({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child:
                  SvgPicture.asset(_Assets.iconCheck, width: 14, height: 14),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.625,
                letterSpacing: -0.150,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Button Component (Primary / Secondary) ───────────────────────────────────

enum ButtonState { primary, secondary }

class AppButton extends StatelessWidget {
  const AppButton.primary({
    super.key,
    required this.label,
    this.iconUrl,
    required this.onPressed,
  }) : state = ButtonState.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
  })  : state = ButtonState.secondary,
        iconUrl = null;

  final String label;
  final String? iconUrl;
  final VoidCallback onPressed;
  final ButtonState state;

  bool get _isPrimary => state == ButtonState.primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _isPrimary ? AppColors.black : AppColors.white,
          foregroundColor:
              _isPrimary ? AppColors.white : AppColors.textSecondary,
          elevation: _isPrimary ? 4 : 0,
          shadowColor:
              _isPrimary ? const Color(0x1A000000) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: _isPrimary
                ? BorderSide.none
                : const BorderSide(color: AppColors.grey2, width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconUrl != null) ...[
              SvgPicture.asset(iconUrl!, width: 20, height: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: -0.313,
                color: _isPrimary ? AppColors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Action Buttons ───────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppButton.primary(
            label: 'Get Directions',
            iconUrl: _Assets.iconDirections,
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          AppButton.secondary(
            label: 'Reschedule Appointment',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
