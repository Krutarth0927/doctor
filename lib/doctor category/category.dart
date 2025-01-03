import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../other/color.dart';
 // Ensure this file contains color definitions

class DoctorCardPage extends StatelessWidget {
  final String? category;

  DoctorCardPage({this.category});

  @override
  Widget build(BuildContext context) {
    var categoryName = category ?? "Doctors";

    var data = _getDoctorData(categoryName);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.text),
        title: Text(
          categoryName,
          style: TextStyle(color: AppColors.text),
        ),
        backgroundColor: AppColors.primary,
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
                              child: Text(
                                "Contact Clinic",
                                style: TextStyle(color: AppColors.text),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookTimeSlotPage(doctor: item['name']),
                                  ),
                                );
                              },
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

class BookTimeSlotPage extends StatefulWidget {
  final String doctor;

  BookTimeSlotPage({required this.doctor});

  @override
  _BookTimeSlotPageState createState() => _BookTimeSlotPageState();
}

class _BookTimeSlotPageState extends State<BookTimeSlotPage> {
  DateTime selectedDate = DateTime.now();
  String? selectedTimeSlot;

  List<String> timeSlots = [
    "9:00 AM - 10:00 AM",
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "2:00 PM - 3:00 PM",
    "3:00 PM - 4:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.text),
        title: Text(
          "Book Time Slot",
          style: TextStyle(color: AppColors.text),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Doctor: ${widget.doctor}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Select Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }

              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(selectedDate),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Select Time Slot",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: timeSlots.map((slot) {
                return ChoiceChip(
                  label: Text(slot),
                  selected: selectedTimeSlot == slot,
                  onSelected: (selected) {
                    setState(() {
                      selectedTimeSlot = selected ? slot : null;
                    });
                  },
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (selectedTimeSlot != null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Booking Confirmed"),
                      content: Text(
                          "Your booking with ${widget.doctor} on ${DateFormat('yyyy-MM-dd').format(selectedDate)} at $selectedTimeSlot is confirmed."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a time slot.")),
                  );
                }
              },
              child: Text("Confirm Booking",style: TextStyle(color: AppColors.text),),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
