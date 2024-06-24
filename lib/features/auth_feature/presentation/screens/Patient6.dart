import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/widgets/text_widget.dart';
import 'button_nav_bar.dart';
import 'detail_patient.dart';

class Patient6 extends StatefulWidget {
  const Patient6({Key? key});

  @override
  State<Patient6> createState() => _PatientState();
}

class _PatientState extends State<Patient6> {
  List<String> imagePatients = [
    "assets/images/pat2.jpeg",
    "assets/images/pat3.jpeg",
    "assets/images/pat4.jpeg",
    "assets/images/pat5.jpeg",
    "assets/images/pat6.jpeg",
    "assets/images/pat7.jpeg",
    "assets/images/pat8.jpeg",
    "assets/images/pat9.jpeg",
    "assets/images/pat10.jpeg",
    "assets/images/pat3.jpeg",
  ];
  List<Map<String, dynamic>> patients = [];
  bool isLoading = true; // Add this boolean variable

  @override
  void initState() {
    super.initState();
    retrievePatients();
  }

  Future<void> retrievePatients() async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient5');
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'status': doc['status'],
          };
        }).toList();
        isLoading = false; // Set isLoading to false once data is fetched
      });
      print('Patients retrieved successfully');
    } catch (e) {
      setState(() {
        isLoading = false; // Set isLoading to false in case of error
      });
      print('Failed to retrieve patients: $e');
    }
  }

  Future<void> addNewPatient(String name, String patientStatus) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient5');
      DocumentReference newPatient = await patientsRef.add({
        'name': name,
        'status': patientStatus,
      });
      setState(() {
        patients.add({
          'id': newPatient.id,
          'name': name,
          'status': patientStatus,
        });
      });
      print('Patient added successfully');
    } catch (e) {
      print('Failed to add patient: $e');
    }
  }

  Future<void> deletePatient(String id, int index) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient5');
      await patientsRef.doc(id).delete();
      setState(() {
        patients.removeAt(index);
      });
      print('Patient deleted successfully');
    } catch (e) {
      print('Failed to delete patient: $e');
    }
  }

  Future<void> updatePatient(int index) async {
    try {
      String currentName = patients[index]['name'];
      String currentStatus = patients[index]['status'];
      String currentId = patients[index]['id'];

      // Controllers for text fields
      TextEditingController _nameController = TextEditingController(text: currentName);
      TextEditingController _statusController = TextEditingController(text: currentStatus);

      // Show confirmation dialog
      bool confirmUpdate = await showConfirmationDialog(context);
      if (confirmUpdate) {
        // Show update dialog
        bool updateConfirmed = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('Update Patient'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _statusController,
                        decoration: InputDecoration(labelText: 'Status'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Cancel update
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String updatedName = _nameController.text.trim();
                        String updatedStatus = _statusController.text.trim();
                        if (updatedName.isNotEmpty && updatedStatus.isNotEmpty) {
                          // Update patient data in Firestore
                          await updatePatientData(currentId, updatedName, updatedStatus);
                          // Update local state
                          setState(() {
                            patients[index]['name'] = updatedName;
                            patients[index]['status'] = updatedStatus;
                          });
                          Navigator.of(context).pop(true); // Confirm update
                          // Show success dialog after updating patient
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Success'),
                                content: Text('Patient updated successfully.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Update'),
                    ),
                  ],
                );
              },
            );
          },
        );

        // Handle confirmation result
        if (updateConfirmed == true) {
          print('Patient updated successfully');
        } else {
          print('Update operation cancelled');
        }
      }
    } catch (e) {
      print('Failed to update patient: $e');
    }
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Update'),
          content: Text('Are you sure you want to update this patient?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if cancel is pressed
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if update is confirmed
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    ) ?? false; // Return false by default
  }

  Future<void> updatePatientData(String id, String updatedName, String updatedStatus) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient5');
      await patientsRef.doc(id).update({
        'name': updatedName,
        'status': updatedStatus,
      });
      print('Patient updated successfully');
    } catch (e) {
      print('Failed to update patient: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "All Patients",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddPatientDialog(
                    onAddPatient: addNewPatient,
                  );
                },
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: isLoading // Display CircularProgressIndicator if loading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
          : ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeatailPatient(
                      name: patients[index]['name'],
                      status: patients[index]['status'],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.only(left: 20),
                height: 120,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePatients[index % imagePatients.length],
                        width: 70,
                        height: 70,
                      ),
                    ),
                    SizedBox(width: 13),
                    Expanded(
                      child: DetailDoctors(
                        title: patients[index]['name'],
                        subTitle: patients[index]['status'],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await updatePatient(index);
                        setState(() {
                          // Update state if needed
                        });
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deletePatient(patients[index]['id'], index);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: ButtonNavBar(initialIndex: 2),
    );
  }
}

class DetailDoctors extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const DetailDoctors({Key? key, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            TextWidget(
              title: title!,
              titleSize: 19,
              titleFontWeight: FontWeight.bold,
              titleColor: Colors.black,
            ),
          SizedBox(height: 10),
          if (subTitle != null)
            TextWidget(
              title: subTitle!,
              titleSize: 16,
              titleColor: Colors.grey,
            ),
        ],
      ),
    );
  }
}

class AddPatientDialog extends StatefulWidget {
  final Function(String, String) onAddPatient;

  const AddPatientDialog({Key? key, required this.onAddPatient}) : super(key: key);

  @override
  _AddPatientDialogState createState() => _AddPatientDialogState();
}

class _AddPatientDialogState extends State<AddPatientDialog> {
  late TextEditingController nameController;
  late TextEditingController statusController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    statusController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Patient'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: statusController,
            decoration: InputDecoration(labelText: 'Status'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String name = nameController.text.trim();
            String status = statusController.text.trim();
            if (name.isNotEmpty && status.isNotEmpty) {
              widget.onAddPatient(name, status);
              Navigator.of(context).pop();
              // Show success dialog after adding patient
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text('Patient added successfully.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  final String title;
  final double titleSize;
  final FontWeight titleFontWeight;
  final Color titleColor;

  const TextWidget({
    Key? key,
    required this.title,
    this.titleSize = 16,
    this.titleFontWeight = FontWeight.normal,
    this.titleColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: titleSize,
        fontWeight: titleFontWeight,
        color: titleColor,
      ),
    );
  }
}
