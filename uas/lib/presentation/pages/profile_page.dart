import 'package:flutter/material.dart';
import 'package:uas/core/api/api_service.dart';
import 'package:uas/domain/entities/user.dart';
import 'package:uas/presentation/pages/base_page.dart';
import 'package:uas/presentation/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  final HomeController controller;
  final ApiService apiService = ApiService();

  ProfilePage(this.controller, {super.key});

  Future<String?> _getValidToken(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      _redirectToLogin(context);
      return null;
    }

    debugPrint('Token: $token');
    return token;
  }

  void _redirectToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _redirectToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<String?>(
      future: _getValidToken(context),
      builder: (context, tokenSnapshot) {
        // Handle token loading/error
        if (tokenSnapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading(controller); // Menggunakan controller
        }

        if (tokenSnapshot.hasError || !tokenSnapshot.hasData) {
          return _buildTokenError(context);
        }

        return FutureBuilder<User>(
          future: apiService.getLoggedInUser(tokenSnapshot.data!),
          builder: (context, userSnapshot) {
            // Handle user data loading
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return _buildLoading(controller); // Menggunakan controller
            }

            // Handle API errors
            if (userSnapshot.hasError) {
              return _buildApiError(context, userSnapshot.error);
            }

            // Handle empty data
            if (!userSnapshot.hasData) {
              return _buildNoData(context);
            }

            // Build main UI
            return _buildProfileUI(context, userSnapshot.data!, theme);
          },
        );
      },
    );
  }

  Widget _buildProfileUI(BuildContext context, User user, ThemeData theme) {
    return BasePage(
      bodyContent: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(user, theme),
            const SizedBox(height: 24),
            _buildUserInfoCard(user, theme),
            const SizedBox(height: 32),
            _buildLogoutButton(context, theme),
          ],
        ),
      ),
      selectedIndex: 3,
      controller: controller,
    );
  }

  Widget _buildProfileHeader(User user, ThemeData theme) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Positioned(
          bottom: -30,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: theme.colorScheme.primary,
            child: user.avatarUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      user.avatarUrl!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildDefaultAvatar(theme),
                    ),
                  )
                : _buildDefaultAvatar(theme),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar(ThemeData theme) {
    return Icon(
      Icons.person,
      size: 50,
      color: theme.colorScheme.onPrimary,
    );
  }

  Widget _buildUserInfoCard(User user, ThemeData theme) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(
              icon: Icons.person,
              label: 'Nama',
              value: user.name,
              theme: theme,
            ),
            const Divider(height: 32),
            _buildInfoRow(
              icon: Icons.email,
              label: 'Email',
              value: user.email,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, ThemeData theme) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Logout'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        iconColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => _logout(context),
    );
  }

  Widget _buildLoading(HomeController controller) {
    return BasePage(
      bodyContent: const Center(child: CircularProgressIndicator()),
      selectedIndex: 3,
      controller: controller,
    );
  }

  Widget _buildTokenError(BuildContext context) {
    return BasePage(
      bodyContent: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Autentikasi Gagal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _redirectToLogin(context),
              child: const Text('Kembali ke Login'),
            ),
          ],
        ),
      ),
      selectedIndex: 3,
      controller: controller,
    );
  }

  Widget _buildApiError(BuildContext context, Object? error) {
    return BasePage(
      bodyContent: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber, size: 50, color: Colors.orange),
            const SizedBox(height: 16),
            Text(
              'Gagal Memuat Data',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
      selectedIndex: 3,
      controller: controller,
    );
  }

  Widget _buildNoData(BuildContext context) {
    return BasePage(
      bodyContent: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_off, size: 50, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Data Pengguna Tidak Ditemukan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      selectedIndex: 3,
      controller: controller,
    );
  }
}
