import 'package:flutter/material.dart';

class HomeHeaderSection extends StatelessWidget {
  final bool isSmallScreen;
  final bool isDark;

  const HomeHeaderSection({
    super.key,
    required this.isSmallScreen,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLogoContainer(context),
        SizedBox(height: isSmallScreen ? 12 : 16),
        _buildTitleText(context),
        SizedBox(height: isSmallScreen ? 6 : 8),
        _buildDescriptionText(context),
      ],
    );
  }

  Widget _buildLogoContainer(BuildContext context) {
    return Container(
      width: isSmallScreen ? 100 : 140,
      height: isSmallScreen ? 100 : 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  Colors.grey.shade800.withOpacity(0.3),
                  Colors.grey.shade900.withOpacity(0.1),
                ]
              : [
                  Theme.of(context).primaryColor.withOpacity(0.2),
                  Theme.of(context).primaryColor.withOpacity(0.05),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.5)
                : Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: ClipOval(
          child: Image.asset(
            'assets/images/icon-minang.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.restaurant,
                size: isSmallScreen ? 40 : 60,
                color: Theme.of(context).primaryColor,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Text(
      'Klasifikasi Makanan Minangkabau',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: isSmallScreen ? 18 : 22,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescriptionText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 16),
      child: Text(
        'Unggah foto makanan untuk mengidentifikasi jenis makanan Minangkabau tradisional',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          fontSize: isSmallScreen ? 13 : 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}