import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../address/add_new_address_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://picsum.photos/200',
                            // height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                                child: Icon(
                              Icons.camera_enhance_outlined,
                              size: 24,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(12),
                Text(
                  'Welcome,',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Abu Taleb',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Gap(12),
            LabeledTextField(label: 'Name', hintText: 'name'),
            LabeledTextField(label: 'Email', hintText: 'email'),
            LabeledTextField(label: 'Phone', hintText: 'phone'),
            Gap(12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: Size(MediaQuery.sizeOf(context).width * .90, 50)),
              onPressed: () {},
              child: Text(
                'Update',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Gap(20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * .95,
              color: Colors.grey,
            ),
            Gap(12),
            LabeledTextField(label: 'Current password', hintText: ''),
            LabeledTextField(label: 'New Password', hintText: ''),
            LabeledTextField(label: 'Confirm Password', hintText: ''),
            Gap(12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: Size(MediaQuery.sizeOf(context).width * .90, 50)),
              onPressed: () {},
              child: Text(
                'Change Password',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
