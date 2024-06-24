import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/widgets/text_widget.dart';
import 'button_nav_bar.dart';
import 'detail_patient.dart';

class Patient extends StatefulWidget {
  const Patient({Key? key});

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
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
  bool isLoading = false; // State variable for loading indicator

  @override
  void initState() {
    super.initState();
    retrievePatients();
  }

  Future<void> retrievePatients() async {
    try {
      setState(() {
        isLoading = true; // Show loading indicator
      });

      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'status': doc['status'],
          };
        }).toList();
        isLoading = false; // Hide loading indicator after data is fetched
      });
      print('Patients retrieved successfully');
    } catch (e) {
      print('Failed to retrieve patients: $e');
      setState(() {
        isLoading = false; // Ensure loading indicator is hidden on error
      });
    }
  }

  Future<void> addNewPatient(String name, String patientStatus) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
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
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
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
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
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
    body: isLoading
    ? Center(
    child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Set color to blue
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
    padding: EdgeInsets.all(16),
    child: Row(
    children: [
    ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
    imagePatients[index % imagePatients.length],
    width: 70,
    height: 70,
    fit: BoxFit.cover,
    ),
    ),
    SizedBox(width: 16),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    DetailDoctors(
    title: patients[index]['name'],
    subTitle: patients[index]['status'],
    ),
    SizedBox(height: 6),
    Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
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
      ],
      ),
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
      padding: const EdgeInsets.only(top: 6),
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
          SizedBox(height: 6),
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




/*

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/widgets/text_widget.dart';
import 'button_nav_bar.dart';
import 'detail_patient.dart';

class Patient extends StatefulWidget {
  const Patient({Key? key});

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
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

  @override
  void initState() {
    super.initState();
    retrievePatients();
  }

  Future<void> retrievePatients() async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'status': doc['status'],
          };
        }).toList();
      });
      print('Patients retrieved successfully');
    } catch (e) {
      print('Failed to retrieve patients: $e');
    }
  }

  Future<dynamic> addNewPatient(String name, String status, String roomNumber, String age, String medicamentName, String numberOfDoses, String timeFirstDose, String timeSecondDose, String timeThirdDose) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      DocumentReference newPatient = await patientsRef.add({
        'name': name,
        'status': status,
        'roomNumber': roomNumber,
        'age': age,
        'medicamentName': medicamentName,
        'numberOfDoses': numberOfDoses,
        'timeFirstDose': timeFirstDose,
        'timeSecondDose': timeSecondDose,
        'timeThirdDose': timeThirdDose,
      });
      setState(() {
        patients.add({
          'id': newPatient.id,
          'name': name,
          'status': status,
          'roomNumber': roomNumber,
          'age': age,
          'medicamentName': medicamentName,
          'numberOfDoses': numberOfDoses,
          'timeFirstDose': timeFirstDose,
          'timeSecondDose': timeSecondDose,
          'timeThirdDose': timeThirdDose,
        });
      });
      print('تم إضافة المريض بنجاح');
    } catch (e) {
      print('فشل في إضافة المريض: $e');
    }
  }



  Future<void> deletePatient(String id, int index) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
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
      String currentRoomNumber = patients[index]['roomNumber'];
      String currentAge = patients[index]['age'];
      String currentMedicamentName = patients[index]['medicamentName'];
      String currentNumberOfDoses = patients[index]['numberOfDoses'];
      String currentTimeFirstDose = patients[index]['timeFirstDose'];
      String currentTimeSecondDose = patients[index]['timeSecondDose'];
      String currentTimeThirdDose = patients[index]['timeThirdDose'];
      String currentId = patients[index]['id'];

      // Controllers for text fields
      TextEditingController _nameController =
      TextEditingController(text: currentName);
      TextEditingController _statusController =
      TextEditingController(text: currentStatus);
      TextEditingController _roomNumberController =
      TextEditingController(text: currentRoomNumber);
      TextEditingController _ageController =
      TextEditingController(text: currentAge);
      TextEditingController _medicamentNameController =
      TextEditingController(text: currentMedicamentName);
      TextEditingController _numberOfDosesController =
      TextEditingController(text: currentNumberOfDoses);
      TextEditingController _timeOfFirstDoseController =
      TextEditingController(text: currentTimeFirstDose);
      TextEditingController _timeOfSecondDoseController =
      TextEditingController(text: currentTimeSecondDose);
      TextEditingController _timeOfThirdDoseController =
      TextEditingController(text: currentTimeThirdDose);

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
                  content: SingleChildScrollView(
                    child: Column(
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
                        SizedBox(height: 10),
                        TextField(
                          controller: _roomNumberController,
                          decoration: InputDecoration(labelText: 'Room number'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _ageController,
                          decoration: InputDecoration(labelText: 'Age'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _medicamentNameController,
                          decoration:
                          InputDecoration(labelText: 'Medicament name'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _numberOfDosesController,
                          decoration:
                          InputDecoration(labelText: 'Number of doses'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _timeOfFirstDoseController,
                          decoration:
                          InputDecoration(labelText: 'Time of first dose'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _timeOfSecondDoseController,
                          decoration:
                          InputDecoration(labelText: 'Time of second dose'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _timeOfThirdDoseController,
                          decoration:
                          InputDecoration(labelText: 'Time of third dose'),
                        ),
                      ],
                    ),
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
                        String updatedRoomNumber =
                        _roomNumberController.text.trim();
                        String updatedAge = _ageController.text.trim();
                        String updatedMedicamentName =
                        _medicamentNameController.text.trim();
                        String updatedNumberOfDoses =
                        _numberOfDosesController.text.trim();
                        String updatedTimeOfFirstDose =
                        _timeOfFirstDoseController.text.trim();
                        String updatedTimeOfSecondDose =
                        _timeOfSecondDoseController.text.trim();
                        String updatedTimeOfThirdDose =
                        _timeOfThirdDoseController.text.trim();

                        if (updatedName.isNotEmpty &&
                            updatedStatus.isNotEmpty &&
                            updatedRoomNumber.isNotEmpty &&
                            updatedAge.isNotEmpty &&
                            updatedMedicamentName.isNotEmpty &&
                            updatedNumberOfDoses.isNotEmpty &&
                            updatedTimeOfFirstDose.isNotEmpty &&
                            updatedTimeOfSecondDose.isNotEmpty &&
                            updatedTimeOfThirdDose.isNotEmpty) {
                          // Update patient data in Firestore
                          await updatePatientData(
                            currentId,
                            updatedName,
                            updatedStatus,
                            updatedRoomNumber,
                            updatedAge,
                            updatedMedicamentName,
                            updatedNumberOfDoses,
                            updatedTimeOfFirstDose,
                            updatedTimeOfSecondDose,
                            updatedTimeOfThirdDose,
                          );
                          // Update local state
                          setState(() {
                            patients[index]['name'] = updatedName;
                            patients[index]['status'] = updatedStatus;
                            patients[index]['roomNumber'] = updatedRoomNumber;
                            patients[index]['age'] = updatedAge;
                            patients[index]['medicamentName'] =
                                updatedMedicamentName;
                            patients[index]['numberOfDoses'] =
                                updatedNumberOfDoses;
                            patients[index]['timeFirstDose'] =
                                updatedTimeOfFirstDose;
                            patients[index]['timeSecondDose'] =
                                updatedTimeOfSecondDose;
                            patients[index]['timeThirdDose'] =
                                updatedTimeOfThirdDose;
                          });
                          Navigator.of(context).pop(true); // Confirm update

                          // Show success dialog after updating patient
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Success'),
                                content:
                                Text('Patient updated successfully.'),
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


  Future<void> updatePatientData(
      String id,
      String updatedName,
      String updatedStatus,
      String updatedRoomNumber,
      String updatedAge,
      String updatedMedicamentName,
      String updatedNumberOfDoses,
      String updatedTimeOfFirstDose,
      String updatedTimeOfSecondDose,
      String updatedTimeOfThirdDose,
      ) async {
    try {
      CollectionReference patientsRef =
      FirebaseFirestore.instance.collection('patients');
      await patientsRef.doc(id).update({
        'name': updatedName,
        'status': updatedStatus,
        'roomNumber': updatedRoomNumber,
        'age': updatedAge,
        'medicamentName': updatedMedicamentName,
        'numberOfDoses': updatedNumberOfDoses,
        'timeFirstDose': updatedTimeOfFirstDose,
        'timeSecondDose': updatedTimeOfSecondDose,
        'timeThirdDose': updatedTimeOfThirdDose,
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
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPatient(
                      name: patients[index]['name'],
                      status: patients[index]['status'],
                      roomNumber: patients[index]['roomNumber'],
                      age: patients[index]['age'],
                      medicamentName: patients[index]['medicamentName'],
                      numberOfDoses: patients[index]['numberOfDoses'],
                      timeOfFirstDose: patients[index]['timeOfFirstDose'],
                      timeOfSecondDose: patients[index]['timeOfSecondDose'],
                      timeOfThirdDose: patients[index]['timeOfThirdDose'],
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
  final Function(
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeOfFirstDose,
      String timeOfSecondDose,
      String timeOfThirdDose,
      ) onAddPatient;

  AddPatientDialog({Key? key, required this.onAddPatient}) : super(key: key);

  @override
  _AddPatientDialogState createState() => _AddPatientDialogState();
}

class _AddPatientDialogState extends State<AddPatientDialog> {
  late TextEditingController nameController;
  late TextEditingController statusController;
  late TextEditingController roomNumberController;
  late TextEditingController ageController;
  late TextEditingController medicamentNameController;
  late TextEditingController numberOfDosesController;
  late TextEditingController timeOfFirstDoseController;
  late TextEditingController timeOfSecondDoseController;
  late TextEditingController timeOfThirdDoseController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    statusController = TextEditingController();
    roomNumberController = TextEditingController();
    ageController = TextEditingController();
    medicamentNameController = TextEditingController();
    numberOfDosesController = TextEditingController();
    timeOfFirstDoseController = TextEditingController();
    timeOfSecondDoseController = TextEditingController();
    timeOfThirdDoseController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    statusController.dispose();
    roomNumberController.dispose();
    ageController.dispose();
    medicamentNameController.dispose();
    numberOfDosesController.dispose();
    timeOfFirstDoseController.dispose();
    timeOfSecondDoseController.dispose();
    timeOfThirdDoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Patient'),
      content: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 10),
            TextField(
              controller: roomNumberController,
              decoration: InputDecoration(labelText: 'Room number'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: medicamentNameController,
              decoration: InputDecoration(labelText: 'Medicament name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: numberOfDosesController,
              decoration: InputDecoration(labelText: 'Number of doses'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: timeOfFirstDoseController,
              decoration: InputDecoration(labelText: 'Time of first dose'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: timeOfSecondDoseController,
              decoration: InputDecoration(labelText: 'Time of second dose'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: timeOfThirdDoseController,
              decoration: InputDecoration(labelText: 'Time of third dose'),
            ),
          ],
        ),
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
            String roomNumber = roomNumberController.text.trim();
            String age = ageController.text.trim();
            String medicamentName = medicamentNameController.text.trim();
            String numberOfDoses = numberOfDosesController.text.trim();
            String timeOfFirstDose = timeOfFirstDoseController.text.trim();
            String timeOfSecondDose = timeOfSecondDoseController.text.trim();
            String timeOfThirdDose = timeOfThirdDoseController.text.trim();

            if (name.isNotEmpty &&
                status.isNotEmpty &&
                roomNumber.isNotEmpty &&
                age.isNotEmpty &&
                medicamentName.isNotEmpty &&
                numberOfDoses.isNotEmpty &&
                timeOfFirstDose.isNotEmpty &&
                timeOfSecondDose.isNotEmpty &&
                timeOfThirdDose.isNotEmpty) {
              widget.onAddPatient(
                name,
                status,
                roomNumber,
                age,
                medicamentName,
                numberOfDoses,
                timeOfFirstDose,
                timeOfSecondDose,
                timeOfThirdDose,
              );
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
*/
