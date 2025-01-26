import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../other/color.dart';

import 'package:http/http.dart' as http;
class DoctorBookingPage extends StatefulWidget {
  final doctorId;

  // Constructor to accept the doctor ID
  DoctorBookingPage({required this.doctorId});

  @override
  _DoctorBookingPageState createState() => _DoctorBookingPageState();


}

class _DoctorBookingPageState extends State<DoctorBookingPage> {
  DateTime selectedDate = DateTime.now();
  String? selectedTimeSlot;

  //init state karto kb !!!!!!!!!!!!!!!!!!!!!!!1



  // List of available time slots
  List<String> timeSlots = [
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
  ];

  // Map to track booked slots for each doctor
  Map<String, List<String>> bookedSlots = {
    "Olivia Wilson": [],
    "Jonathan Patterson": [],
  };


  @override
  void initState() {
    super.initState();
    // getSlots();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor ID: ${widget.doctorId}',
        style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.text),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM yyyy').format(selectedDate),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDateRow(),
                  const SizedBox(height: 20),
                  const Text(
                    'Available Doctors',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey[300]),
            _buildDoctorCard(
              "Olivia Wilson",
              "Consultant - Physiotherapy",
              "assets/hospital/2.jpg",
            ),
            Divider(height: 1, color: Colors.grey[300]),
            _buildDoctorCard(
              "Jonathan Patterson",
              "Consultant - Physiotherapy",
              "assets/hospital/2.jpg",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        DateTime day = DateTime.now().add(Duration(days: index));
        bool isSelected = day.day == selectedDate.day;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = day;
            });
          },
          child: Column(
            children: [
              Text(
                DateFormat.E().format(day).toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  border: Border.all(color: AppColors.textSecondary, width: 1),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDoctorCard(String name, String specialty, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 30,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(specialty),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: timeSlots.map((slot) {
              // Check if the slot is booked for this specific doctor
              bool isBooked = bookedSlots[name]?.contains(slot) ?? true;

              return ChoiceChip(
                label: Text(slot),
                selected: selectedTimeSlot == slot && !isBooked,
                onSelected: isBooked
                    ? null // Disable chip if booked
                    : (selected) {
                  setState(() {
                    selectedTimeSlot = selected ? slot : null;
                  });
                },
                selectedColor: AppColors.accent,
                backgroundColor:
                isBooked ? AppColors.textSecondary : Colors.grey[200],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: selectedTimeSlot != null
                  ? () {
                _confirmBooking(name);
              }
                  : null,
              child: const Text(
                "Book Now",
                style: TextStyle(color: AppColors.text),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _confirmBooking(String doctorName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Booking"),
          content: Text(
            "Doctor: $doctorName\n"
                "Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}\n"
                "Time: $selectedTimeSlot",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  bookedSlots[doctorName] = bookedSlots[doctorName] ?? [];
                  bookedSlots[doctorName]!.add(selectedTimeSlot!);
                  selectedTimeSlot = null;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Booking Confirmed!"),
                  ),
                );
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  // void getSlots() async{
  //   Uri url  = Uri.parse("https://easydoc.clotheeo.in/apis/allslots.php");
  //   var response = await http.post(url);
  //
  //   print(response.body);
  // }

}
