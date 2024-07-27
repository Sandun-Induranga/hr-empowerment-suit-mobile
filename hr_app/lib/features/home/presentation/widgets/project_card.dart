import 'package:flutter/material.dart';

import '../../../../core/constants/color_codes.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.name,
    required this.status,
    required this.role,
    required this.startDate,
  });

  final String name;
  final String status;
  final String role;
  final String startDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorCodes.primaryColor.withOpacity(0.1),
      child: ListTile(
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: status == 'In Progress'
                    ? Colors.green
                    : status == 'Completed'
                        ? Colors.blue
                        : Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Status: $status',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text('Role: $role'),
            Text('Start Date: $startDate'),
          ],
        ),
      ),
    );
  }
}
