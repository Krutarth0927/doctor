import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../other/color.dart';

import 'package:http/http.dart' as http;
class DoctorBookingPage extends StatefulWidget {
  var doctorId;

  // Constructor to accept the doctor ID
  DoctorBookingPage({required this.doctorId});

  @override
  _DoctorBookingPageState createState() => _DoctorBookingPageState();


}

class _DoctorBookingPageState extends State<DoctorBookingPage> {
  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    getSlots(selectDate: formattedDate);

  }
  var _oldNew = "old";
  TextEditingController oldnewController = TextEditingController();
  var _value = null;
  bool _isLoading=false;
  DateTime selectedDate = DateTime.now();
  String? selectedTimeSlot;
  var slotsAvailable =[];


  // List of available time slots
  // List<String> timeSlots = [
  //   "09:00",
  //   "09:30",
  //   "10:00",
  //   "10:30",
  //   "11:00",
  //   "11:30",
  //   "12:00",
  //   "13:30",
  //   "14:00",
  //   "14:30",
  //   "15:00",
  //   "15:30",
  //   "16:00",
  //   "16:30",
  // ];

  // Map to track booked slots for each doctor

  Map<String, List<String>> bookedSlots = {
    "Olivia Wilson": [],
    "Jonathan Patterson": [],
  };




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor ID: ${widget.doctorId["ID"]}',
          style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.text),
        elevation: 1,
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(slotsAvailable.length.toString()),
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
              context,
              widget.doctorId['name'],
              widget.doctorId['category'],
              "assets/hospital/2.jpg",
            ),
            Divider(height: 1, color: Colors.grey[300]),

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
              String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
              print(formattedDate);
              getSlots(selectDate: formattedDate);

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

  Widget _buildDoctorCard(BuildContext c, String name, String specialty, String imagePath) {
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
            children:
            List.generate(
              slotsAvailable.length, (int index) {
                return ChoiceChip(
                  padding: EdgeInsets.all(8),
                  label: Text(' ${slotsAvailable[index]['time']}'),

                  selectedColor: Colors.green,

                  selected: _value == index,


                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                      selectedTimeSlot = slotsAvailable[index]['time'];
                    });
                  },
                );
              },
            ).toList(),

          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _value != null
                  ? () {
                _confirmBooking(c,name);
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



  void _confirmBooking(BuildContext context, String doctorName) {
    String? uploadedFileName; // To store the selected file name

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder( // Use StatefulBuilder to manage the dialog's state
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Confirm Booking"),
              content: Column(
                mainAxisSize: MainAxisSize.min, // Adjust size for better layout
                children: [
                  Text(
                    "Doctor: $doctorName\n"
                        "Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}\n"
                        "Time: $selectedTimeSlot \n",
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'old',
                        groupValue: _oldNew,
                        onChanged: (value) {
                          setState(() {
                            _oldNew = value!;
                          });
                        },
                      ),
                      const Text("Old Patient"),
                      Radio<String>(
                        value: 'new',
                        groupValue: _oldNew,
                        onChanged: (value) {
                          setState(() {
                            _oldNew = value!;
                          });
                        },
                      ),
                      const Text("New Patient"),
                    ],
                  ),
                  if (_oldNew == 'old') // Display document upload field for "Old Patient"
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Upload Document",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.upload_file),
                              onPressed: () async {
                                // File Picker logic
                                FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
                                );
                                if (result != null) {
                                  setState(() {
                                    uploadedFileName = result.files.single.name;
                                  });
                                  print("Selected file: ${result.files.single.name}");
                                } else {
                                  print("File selection canceled");
                                }
                              },
                            ),
                          ),
                          readOnly: true, // Make the text box read-only
                          controller: TextEditingController(
                            text: uploadedFileName ?? "No file selected",
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary
                ),
                  onPressed: () {
                    setState(() {
                      bookedSlots[doctorName] = bookedSlots[doctorName] ?? [];
                      bookedSlots[doctorName]!.add(selectedTimeSlot!);
                    });
                    Navigator.pop(context);
                    print('Slot Booked');
                  },
                  child: const Text("Confirm",style: TextStyle(color: AppColors.text),),
                ),
              ],
            );
          },
        );
      },
    );
  }


  void getSlots({required var selectDate}) async{
    _isLoading= true;
    Uri urlSecond  = Uri.parse("https://easydoc.clotheeo.in/apis/check_slot_available.php");

    var responseSecond = await http.post(urlSecond,body: jsonEncode({
      "did" : widget.doctorId["ID"],
      "date" : selectDate.toString()
    }));

    // print(responseSecond.body);
    var alldata = jsonDecode(responseSecond.body);


    setState(() {
      _isLoading= false;
       slotsAvailable = alldata['data'];
      print(slotsAvailable);
    });

  }

}