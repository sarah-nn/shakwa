import 'package:flutter/widgets.dart';
import 'package:shakwa/Views/Widgets/complaints_item.dart';
import 'package:shakwa/dummy_data.dart';

class ComplientsList extends StatelessWidget {
  const ComplientsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          return ComplaintsItem(
            type: complaints[index]['type']!,
            title: complaints[index]['title']!,
            id: complaints[index]['id']!,
            status: complaints[index]['status']!,
          );
        },
      ),
    );
  }
}
