import 'package:flutter/material.dart';
import '../main_navigation_screen.dart';

class BuyerOnboardingScreen extends StatefulWidget {
  const BuyerOnboardingScreen({super.key});

  @override
  State<BuyerOnboardingScreen> createState() => _BuyerOnboardingScreenState();
}

class _BuyerOnboardingScreenState extends State<BuyerOnboardingScreen> {
  int _currentStep = 0;
  double _budget = 5000000;
  String _selectedCity = 'Pune';
  String _selectedBhk = '2BHK';

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Buyer Preferences'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 3) {
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
            title: const Text('Your Name', style: TextStyle(color: Colors.white)),
            content: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your name',
                hintStyle: const TextStyle(color: Color(0xFF64748B)),
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Budget Range', style: TextStyle(color: Colors.white)),
            content: Column(
              children: [
                Text('₹${(_budget / 100000).toStringAsFixed(0)} Lakhs', 
                  style: const TextStyle(color: Color(0xFFF59E0B), fontSize: 18, fontWeight: FontWeight.bold)),
                Slider(
                  value: _budget,
                  min: 1000000,
                  max: 50000000,
                  divisions: 50,
                  activeColor: const Color(0xFF6366F1),
                  onChanged: (val) {
                    setState(() => _budget = val);
                  },
                ),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Location', style: TextStyle(color: Colors.white)),
            content: DropdownButtonFormField<String>(
              value: _selectedCity,
              dropdownColor: const Color(0xFF1E293B),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: ['Pune', 'Bangalore', 'Mumbai', 'Delhi'].map((city) {
                return DropdownMenuItem(value: city, child: Text(city));
              }).toList(),
              onChanged: (val) => setState(() => _selectedCity = val!),
            ),
            isActive: _currentStep >= 2,
          ),
          Step(
            title: const Text('Configuration', style: TextStyle(color: Colors.white)),
            content: DropdownButtonFormField<String>(
              value: _selectedBhk,
              dropdownColor: const Color(0xFF1E293B),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: ['1BHK', '2BHK', '3BHK', '4BHK+'].map((bhk) {
                return DropdownMenuItem(value: bhk, child: Text(bhk));
              }).toList(),
              onChanged: (val) => setState(() => _selectedBhk = val!),
            ),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
    );
  }
}
