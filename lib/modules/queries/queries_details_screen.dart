import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../core/common/widgets/custom_text_form_field.dart';

class QueriesDetailsScreen extends StatelessWidget {
  const QueriesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queries Details'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Text(
                      'Query',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(': I needs bulk products'),
                  ],
                ),
                Row(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: MediaQuery.sizeOf(context).width * .65, child: Text(': Contrary to popular belief, Lorem Ipsum is not simply')),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              spacing: 12,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(borderRadius: BorderRadius.circular(40), child: Image.network('https://picsum.photos/708')),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'You',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('15 August 2024 | 10:45 PM'),
                  ],
                ),
              ],
            ),
          ),
          Gap(12),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.7,
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour,',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Seen',
                  style: TextStyle(color: Colors.blue),
                ),
                Icon(
                  Icons.done_all_outlined,
                  color: Colors.blue,
                ),
                Gap(12),
              ],
            ),
          ),
          Gap(12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
              hintText: 'Type your reply',
              maxLines: 5,
              filled: false,
              borderDecoration: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Gap(12),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Text('Send'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
