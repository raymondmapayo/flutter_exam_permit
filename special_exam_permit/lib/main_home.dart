import 'package:flutter/material.dart';
import 'package:special_exam_permit/components/animate_scroll.dart';
import 'package:special_exam_permit/screens/special_exam_landing/about_section.dart';
import 'package:special_exam_permit/screens/special_exam_landing/contact_section.dart';
import 'package:special_exam_permit/screens/special_exam_landing/eligibility_section.dart';
import 'package:special_exam_permit/screens/special_exam_landing/hero_section.dart';
import 'package:special_exam_permit/screens/special_exam_landing/steps_section.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UMTheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // Hero plays immediately since it's visible on first load —
            // no need to wrap it in RevealOnScroll.
            HeroSection(),
            RevealOnScroll(child: AboutSection()),
            RevealOnScroll(child: EligibilitySection()),
            RevealOnScroll(child: StepsSection()),
            RevealOnScroll(child: ContactSection()),
          ],
        ),
      ),
    );
  }
}
