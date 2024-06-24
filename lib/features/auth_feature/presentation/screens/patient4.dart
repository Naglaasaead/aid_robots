
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/widgets/text_widget.dart';
import 'Patient6.dart';
import 'button_nav_bar.dart';
import 'detail_patient.dart';

class Patient4 extends StatefulWidget {
  const Patient4({Key? key});

  @override
  State<Patient4> createState() => _PatientState();
}

class _PatientState extends State<Patient4> {
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    retrievePatients();
  }

  Future<void> retrievePatients() async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient3');
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'status': doc['status'],
          };
        }).toList();
        _isLoading = false; // Data loading complete
      });
      print('Patients retrieved successfully');
    } catch (e) {
      print('Failed to retrieve patients: $e');
      setState(() {
        _isLoading = false; // Data loading failed
      });
    }
  }

  Future<void> addNewPatient(String name, String patientStatus) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient3');
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
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient3');
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
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient3');
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
      body: _isLoading
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

