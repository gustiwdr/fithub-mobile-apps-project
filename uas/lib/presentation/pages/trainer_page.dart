import 'package:flutter/material.dart';
import 'base_page.dart';
import '../../core/api/api_service.dart';
import '../controllers/home_controller.dart';

class TrainerPage extends StatelessWidget {
  final HomeController controller;

  const TrainerPage(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final Color primaryColor = Colors.blue[800]!;

    return BasePage(
      bodyContent: FutureBuilder<List<dynamic>>(
        future: apiService.getAllTrainers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 2.5,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red[600], fontSize: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No trainers available',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            );
          } else {
            final List<dynamic> trainers = snapshot.data!;

            return Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Our Trainers',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),

                    // Trainer List
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemCount: trainers.length,
                        itemBuilder: (context, index) {
                          final trainer = trainers[index];

                          return Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Profile Image
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: trainer.profilePicture.isNotEmpty
                                          ? Image.network(
                                              '${apiService.baseImageUrl}/${trainer.profilePicture}',
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) =>
                                                  Icon(
                                                Icons.person,
                                                color: Colors.grey[400],
                                                size: 40,
                                              ),
                                            )
                                          : Icon(
                                              Icons.person,
                                              color: Colors.grey[400],
                                              size: 40,
                                            ),
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // Profile Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trainer.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          trainer.expertise,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        _buildInfoRow(
                                          icon: Icons.phone,
                                          value: trainer.phone,
                                          color: Colors.grey[600]!,
                                        ),
                                        _buildInfoRow(
                                          icon: Icons.mail,
                                          value: trainer.email,
                                          color: Colors.grey[600]!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      selectedIndex: 2,
      controller: controller,
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
