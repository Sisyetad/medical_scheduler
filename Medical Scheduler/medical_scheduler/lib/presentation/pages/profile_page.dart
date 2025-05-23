import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/providers/auth_provider.dart';
import 'package:medical_scheduler/presentation/widgets/edit_profile_widget.dart';
import 'package:medical_scheduler/presentation/widgets/profile_widget.dart';
import 'package:medical_scheduler/presentation/widgets/side_bar.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  bool isProfile = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    final user = state.user;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => setState(() => isProfile = true),
                          child: const Text('Profile'),
                        ),
                        TextButton(
                          onPressed: () => setState(() => isProfile = false),
                          child: const Text('Edit Profile'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (user != null)
                      isProfile
                          ? ProfileWidget(user: user)
                          : const EditProfileWidget()
                    else
                      const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Back to home
                        },
                        child: const Text('Back To Home'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
