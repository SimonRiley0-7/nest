import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/user_role.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF1E293B),
            child: Icon(Icons.person, size: 50, color: Color(0xFF6366F1)),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('NEST User', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          const SizedBox(height: 4),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.4)),
              ),
              child: Text(
                'Active as ${provider.activeRole.name.toUpperCase()}',
                style: const TextStyle(color: Color(0xFF818CF8), fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Role Switching Section
          const Text('Switch Role', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, letterSpacing: 1)),
          const SizedBox(height: 8),
          _buildRoleTile(context, provider, UserRole.buyer, 'Buyer', Icons.search, const Color(0xFF6366F1)),
          _buildRoleTile(context, provider, UserRole.owner, 'Property Owner', Icons.home_work_outlined, const Color(0xFFF59E0B)),
          _buildRoleTile(context, provider, UserRole.builder, 'Builder', Icons.business, const Color(0xFF10B981)),

          const SizedBox(height: 24),
          const Divider(color: Color(0xFF1E293B)),
          const SizedBox(height: 16),

          const Text('Account', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, letterSpacing: 1)),
          const SizedBox(height: 8),
          _buildListTile(Icons.notifications, 'Notification Preferences'),
          _buildListTile(Icons.security, 'Privacy & Security'),
          _buildListTile(Icons.help, 'Help & Support'),

          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: () {
              provider.logout();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Log Out', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleTile(BuildContext context, AppProvider provider, UserRole role, String label, IconData icon, Color color) {
    final isActive = provider.activeRole == role;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.1) : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? color.withOpacity(0.5) : const Color(0xFF334155)),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(label, style: TextStyle(color: Colors.white, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        trailing: isActive
            ? Icon(Icons.check_circle, color: color)
            : const Icon(Icons.radio_button_unchecked, color: Color(0xFF64748B)),
        onTap: () {
          provider.switchRole(role);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Switched to $label mode'),
              backgroundColor: color,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF818CF8)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF64748B)),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    );
  }
}

