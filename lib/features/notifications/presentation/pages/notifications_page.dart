import 'package:flutter/material.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NotificationModel> notifications = [
      const NotificationModel(
        id: '1',
        title: 'Application Update',
        message: 'Your application for Mobile Developer at Vois has been moved to "Under Review".',
        time: '2 hours ago',
      ),
      const NotificationModel(
        id: '2',
        title: 'New Internship',
        message: 'A new UI/UX Design internship has been posted by Designers Hub matching your skills.',
        time: '5 hours ago',
      ),
      const NotificationModel(
        id: '3',
        title: 'Course Completed',
        message: 'Congratulations! You have successfully completed the Flutter Basics course.',
        time: 'Yesterday',
        isRead: true,
      ),
    ];

    return PageScaffold(
      title: 'Notifications',
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Mark all as read', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
        ),
      ],
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.cardBorder.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.notifications_off_outlined, size: 64, color: AppColors.mutedText.withValues(alpha: 0.4)),
                  ),
                  const SizedBox(height: 24),
                  const SectionHeader(
                    title: 'No notifications yet',
                    subtitle: 'We\'ll notify you when something important happens.',
                    centered: true,
                  ),
                ],
              ),
            )
          : Column(
              children: notifications.map((n) => _buildNotificationCard(n)).toList(),
            ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: notification.isRead 
                    ? AppColors.primaryBlue.withValues(alpha: 0.05) 
                    : AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                notification.isRead ? Icons.notifications_none_rounded : Icons.notifications_active_rounded,
                color: notification.isRead ? AppColors.mutedText : AppColors.primaryBlue,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.bold,
                          fontSize: 15,
                          color: notification.isRead ? AppColors.darkNavy.withValues(alpha: 0.7) : AppColors.darkNavy,
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: TextStyle(
                      color: notification.isRead ? AppColors.mutedText : AppColors.darkNavy.withValues(alpha: 0.8),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    notification.time,
                    style: const TextStyle(color: AppColors.mutedText, fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

