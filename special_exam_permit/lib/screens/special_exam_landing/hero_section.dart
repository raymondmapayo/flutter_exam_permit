import 'package:flutter/material.dart';
import 'package:special_exam_permit/components/meta_iteml.dart';
import 'package:special_exam_permit/model/hero_content_model.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: UMTheme.maroon,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BADGE + LOGIN PORTAL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // NOW ACCEPTING REQUESTS
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: UMTheme.gold,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  heroContent.badge,
                  style: const TextStyle(
                    color: UMTheme.maroon,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
              ),

              // LOGIN PORTAL
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/login-page');
                },
                icon: const Icon(
                  Icons.login_outlined,
                  color: Colors.white,
                  size: 18,
                ),
                label: const Text(
                  'Login Portal',
                  style: TextStyle(
                    color: UMTheme.goldLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // TITLE
          Text(
            heroContent.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),

          const SizedBox(height: 14),

          // DESCRIPTION
          Text(
            heroContent.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 26),

          // META INFORMATION
          Row(
            children: [
              Expanded(
                child: MetaItem(
                  label: heroContent.filingWindowLabel,
                  value: heroContent.filingWindowValue,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: MetaItem(
                  label: heroContent.processedByLabel,
                  value: heroContent.processedByValue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
