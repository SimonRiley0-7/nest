import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../models/user_role.dart';
import 'buyer_onboarding_screen.dart';
import 'owner_onboarding_screen.dart';
import 'builder_onboarding_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _selectRole(BuildContext context, UserRole role) {
    Provider.of<AppProvider>(context, listen: false).switchRole(role);
    
    Widget nextScreen;
    switch (role) {
      case UserRole.buyer:
        nextScreen = const BuyerOnboardingScreen();
        break;
      case UserRole.owner:
        nextScreen = const OwnerOnboardingScreen();
        break;
      case UserRole.builder:
        nextScreen = const BuilderOnboardingScreen();
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'How would you like to continue?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            _buildRoleCard(
              context,
              title: 'Continue as Buyer',
              subtitle: 'Search for your dream home with AI assistance.',
              icon: Icons.search,
              role: UserRole.buyer,
              color: const Color(0xFF6366F1),
            ),
            const SizedBox(height: 24),
            _buildRoleCard(
              context,
              title: 'List a Property (Owner)',
              subtitle: 'Sell your own property directly to buyers.',
              icon: Icons.home_work_outlined,
              role: UserRole.owner,
              color: const Color(0xFFF59E0B),
            ),
            const SizedBox(height: 24),
            _buildRoleCard(
              context,
              title: 'List as Builder',
              subtitle: 'List multiple projects and units for your company.',
              icon: Icons.business,
              role: UserRole.builder,
              color: const Color(0xFF10B981),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required UserRole role,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _selectRole(context, role),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF64748B), size: 16),
          ],
        ),
      ),
    );
  }
}
