import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Emon Khan',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '95%',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileStat(icon: Icons.favorite, label: '5 lives Saved'),
                      SizedBox(width: 20),
                      ProfileStat(icon: Icons.star, label: 'SuperHero'),
                      SizedBox(width: 20),
                      ProfileStat(icon: Icons.thumb_up, label: '12 appreciations'),
                    ],
                  ),
                ],
              ),
            ),
            SwitchListTile(
              tileColor: Colors.white,
              title: const Text('Available to Donate',style: TextStyle(color: Colors.black),),
              value: true,
              onChanged: (bool value) {},
              activeColor: Colors.green,
            ),
            const ProfileMenuOption(title: 'Manage Addresses'),
            const ProfileMenuOption(title: 'Reward Points'),
            const ProfileMenuOption(title: 'Donor Card'),
            const ProfileMenuOption(title: 'Badges'),
            const ProfileMenuOption(title: 'Locations'),
          ],
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileStat({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class ProfileMenuOption extends StatelessWidget {
  final String title;

  const ProfileMenuOption({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(title,style: const TextStyle(color: Colors.black),),
      trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
      onTap: () {
      },
    );
  }}