import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixa_project/modules/components/general_button.dart';
import 'package:pixa_project/utils/profile_data.dart';
import 'package:pixa_project/utils/router/routers.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Name:\n${ProfileData.instance.model?.username ?? ''}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Email Address:\n${ProfileData.instance.model?.email ?? ''}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            GeneralButton(
              text: 'Logout',
              onTap: () {
                ProfileData.instance.clear();
                context.goNamed(Routers.rootName);
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
