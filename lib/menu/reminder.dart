import 'package:flutter/material.dart';
import '../other/color.dart';

class ReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders", style: TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.text),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/reminder.png',
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            "You have no reminders.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              "Set a reminder for medicines, to drink enough water, or to take a break at work.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddReminder()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Add a reminder",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.text,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Reminder", style: TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.text),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Time",
                hintText: "Select Time",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.access_time),
              ),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                // Handle selected time (optional logic can go here)
              },
            ),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Date",
                hintText: "Select Date",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                // Handle selected date (optional logic can go here)
              },
            ),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Enter reminder details",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Handle save reminder (optional logic can go here)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Save Reminder",
                style: TextStyle(fontSize: 16, color: AppColors.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
