import 'package:flutter/material.dart';

class DoctorCardPage extends StatelessWidget {
  final String? category;

  DoctorCardPage({this.category}); // Make it nullable

  @override
  Widget build(BuildContext context) {
    var categoryName = category ?? "Doctors";

    var data = _getDoctorData(categoryName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Doctors for $categoryName",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              for (var item in data)
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(item['image'] ?? ''),
                              radius: 30,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(item['specialty'] ?? ''),
                                SizedBox(height: 5),
                                Text("Experience: ${item['experience']} years"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text("Location: ${item['location']}"),
                        Text("Consultation Fee: ₹${item['fee']}"),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Contact Clinic"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text("Book Clinic Visit"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getDoctorData(String category) {
    return [
      {
        "name": "Dr. Venkatesh Babu G M",
        "specialty": "Psychiatrist",
        "experience": 18,
        "location": "HSR Layout",
        "fee": 1200,
        "image": "https://via.placeholder.com/150",
      },
      {
        "name": "Dr. Shobha Krishna",
        "specialty": "Psychiatrist",
        "experience": 32,
        "location": "Jayanagar",
        "fee": 1500,
        "image": "https://via.placeholder.com/150",
      },
    ];
  }
}
