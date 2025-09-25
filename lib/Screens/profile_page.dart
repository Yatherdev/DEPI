import 'package:flutter/material.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, dynamic>> menuItems = const [
    {"icon": Icons.people, "title": "الأصدقاء"},
    {"icon": Icons.group, "title": "المجموعات"},
    {"icon": Icons.article, "title": "الأخبار"},
    {"icon": Icons.help, "title": "المساعدة والدعم"},
    {"icon": Icons.settings, "title": "الإعدادات والخصوصية"},
    {"icon": Icons.logout, "title": "تسجيل الخروج"},
  ];

  bool isFollowed = false;

  void _followed() {
    setState(() {
      isFollowed = !isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // صورة الغلاف وصورة البروفايل
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.asset(
                  "Assets/images/person1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -50,
                child: ClipOval(
                  child: Image.asset(
                    "Assets/images/person2.jpg",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 60),

          // اسم المستخدم
          const Text(
            "Ahmed Yasser",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),

          const SizedBox(height: 10),

          // الأزرار
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _followed();
                },
                label: isFollowed ? Text('متابعه') : Text('أنت تتابعه'),
                icon: Icon(
                  isFollowed?Icons.person_add:Icons.person,
                  color:
                      isFollowed ? Colors.white.withOpacity(.5) : Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                label: const Text('Message'),
                icon: const Icon(Icons.message),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // القائمة (ListView) جوة Expanded عشان تاخد باقي الشاشة
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return ListTile(
                  leading: Icon(item["icon"], color: Colors.blue),
                  title: Text(
                    item["title"],
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    if (item["title"] == "تسجيل الخروج") {
                      exit(0); // خروج من التطبيق
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("تم الضغط على ${item["title"]}"),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
