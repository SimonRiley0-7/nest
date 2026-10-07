import 'package:flutter/material.dart';
import '../main_navigation_screen.dart';

class OwnerOnboardingScreen extends StatefulWidget {
  const OwnerOnboardingScreen({super.key});

  @override
  State<OwnerOnboardingScreen> createState() => _OwnerOnboardingScreenState();
}

class _OwnerOnboardingScreenState extends State<OwnerOnboardingScreen> {
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
        title: const Text('List Property (Owner)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 6) {
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
            title: const Text('Contact Details', style: TextStyle(color: Colors.white)),
            content: Column(
              children: [
                _buildTextField('Full Name'),
                _buildTextField('Contact Number'),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Property Details', style: TextStyle(color: Colors.white)),
            content: Column(
              children: [
                _buildTextField('Duration of Ownership (Years)'),
                _buildTextField('Selling Price (₹)'),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Media Upload', style: TextStyle(color: Colors.white)),
            content: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF64748B), style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Tap to Upload Photos/Videos', style: TextStyle(color: Color(0xFF64748B))),
              ),
            ),
            isActive: _currentStep >= 2,
          ),
          Step(
            title: const Text('Building Information', style: TextStyle(color: Colors.white)),
            content: Column(
              children: [
                _buildTextField('Age of Building (Years)'),
                _buildTextField('Exact Location / Address'),
              ],
            ),
            isActive: _currentStep >= 3,
          ),
          Step(
            title: const Text('Surrounding Area', style: TextStyle(color: Colors.white)),
            content: _buildTextField('Nearby Schools, Hospitals, Transport...'),
            isActive: _currentStep >= 4,
          ),
          Step(
            title: const Text('Legal Documents', style: TextStyle(color: Colors.white)),
            content: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF64748B), style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Upload Title Deed, Tax Receipts (Secured)', style: TextStyle(color: Color(0xFF64748B))),
              ),
            ),
            isActive: _currentStep >= 5,
          ),
          Step(
            title: const Text('Review & Create', style: TextStyle(color: Colors.white)),
            content: const Text('Please review all details before submitting.', style: TextStyle(color: Colors.white)),
            isActive: _currentStep >= 6,
          ),
        ],
      ),
    );
  }
}
