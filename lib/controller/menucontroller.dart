import 'package:d2/other/color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../menu/reminder.dart';


class menucontroller extends GetxController {
  var time = ''.obs;
  var date = ''.obs;
  var description = ''.obs;

  void saveReminder() {
    if (time.isNotEmpty && date.isNotEmpty && description.isNotEmpty) {
      // Parse selected time and date to DateTime
      try {
        DateTime selectedDateTime = _parseDateTime(date.value, time.value);

        if (selectedDateTime.isAfter(DateTime.now())) {
          // Schedule notification
          NotificationService.scheduleNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            title: "Reminder",
            body: description.value,
            scheduledTime: selectedDateTime,
          );

          Get.back(); // Navigate back
          Get.snackbar(
            "Reminder Saved",
            "Your reminder has been successfully scheduled.",
            snackPosition: SnackPosition.TOP,
          );
        } else {
          Get.snackbar(
            "Error",
            "Selected time must be in the future.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.red,
            colorText: AppColors.text,
          );
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Invalid date or time format. Please check your inputs.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red,
          colorText: AppColors.text,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all fields.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red,
        colorText: AppColors.text,
      );
    }
  }

  DateTime _parseDateTime(String date, String time) {
    // Clean up the time string to remove unexpected parts.
    time = time.split(' ')[0] + ' ' + time.split(' ')[1]; // Removes "at 6" or other extra text.

    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
    final DateFormat timeFormatter = DateFormat('h:mm a');

    final DateTime parsedDate = dateFormatter.parse(date);
    final DateTime parsedTime = timeFormatter.parse(time);

    return DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }
}