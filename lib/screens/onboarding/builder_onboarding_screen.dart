import 'package:flutter/material.dart';
import '../main_navigation_screen.dart';

class BuilderOnboardingScreen extends StatefulWidget {
  const BuilderOnboardingScreen({super.key});

  @override
  State<BuilderOnboardingScreen> createState() => _BuilderOnboardingScreenState();
}

class _BuilderOnboardingScreenState extends State<BuilderOnboardingScreen> {
  int _currentStep = 0;

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF64748B)),
          filled: true,
          fillColor: const Color(0xFF1E293B),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('List Project (Builder)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 7) {
            setState(() => _currentStep += 1);
          } else {
            _finishOnboarding();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            Navigator.pop(context);
          }
        },
        steps: [
          Step(
            title: const Text('Company Details', style: TextStyle(color: Colors.white)),
            content: Column(
              children: [
                _buildTextField('Company Name'),
                _buildTextField('Contact Details'),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Project Name', style: TextStyle(color: Colors.white)),
            content: _buildTextField('Scheme / Project Name'),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Unit Configurations', style: TextStyle(color: Colors.white)),
            content: Column(
              children: [
                _buildTextField('e.g. 2BHK - 1200 Sq Ft - ₹70L'),
                _buildTextField('e.g. 3BHK - 1800 Sq Ft - ₹1.2Cr'),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
          Step(
            title: const Text('Location', style: TextStyle(color: Colors.white)),
            content: _buildTextField('Project Address / City'),
            isActive: _currentStep >= 3,
          ),
          Step(
            title: const Text('Legal & Registration', style: TextStyle(color: Colors.white)),
            content: _buildTextField('RERA Registration Number / Business ID'),
            isActive: _currentStep >= 4,
          ),
          Step(
            title: const Text('Media', style: TextStyle(color: Colors.white)),
            content: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF64748B), style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Upload Project Photos/Videos', style: TextStyle(color: Color(0xFF64748B))),
              ),
            ),
            isActive: _currentStep >= 5,
          ),
          Step(
            title: const Text('Surrounding Area', style: TextStyle(color: Colors.white)),
            content: _buildTextField('Amenities, Nearby Transport, Schools...'),
            isActive: _currentStep >= 6,
          ),
          Step(
            title: const Text('Review & Publish', style: TextStyle(color: Colors.white)),
            content: const Text('Review project details before publishing.', style: TextStyle(color: Colors.white)),
            isActive: _currentStep >= 7,
          ),
        ],
      ),
    );
  }
}
