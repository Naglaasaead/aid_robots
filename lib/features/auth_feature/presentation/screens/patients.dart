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
    builder: (context) => DetailPatient(
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



*/



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
    retrievePatients(); // Move data retrieval to initState
  }
  Future<void> retrievePatients() async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?; // استخدام doc.data() للحصول على البيانات مع التحقق من القيمة
          return {
            'id': doc.id,
            'name': data?['name'] ?? '',
            'status': data?['status'] ?? '',
            'roomNumber': data?['roomNumber'] ?? '',
            'age': data?['age'] ?? '',
            'medicamentName': data?['medicamentName'] ?? '',
            'numberOfDoses': data?['numberOfDoses'] ?? '',
            'timeFirstDose': data?.containsKey('timeFirstDose') ?? false ? data != null?['timeFirstDose'] : '',
            'timeSecondDose': data?.containsKey('timeSecondDose') ?? false ? data!['timeSecondDose'] : '',
            'timeThirdDose': data?.containsKey('timeThirdDose') ?? false ? data!['timeThirdDose'] : '',
          };
        }).toList();
      });
      print('Patients retrieved successfully');
    } catch (e) {
      print('Failed to retrieve patients: $e');
    }
  }


  Future<dynamic> addNewPatient(
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose) async {
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
      String currentName = patients[index]['name'] ?? '';
      String currentStatus = patients[index]['status'] ?? '';
      String currentRoomNumber = patients[index]['roomNumber'] ?? '';
      String currentAge = patients[index]['age'] ?? '';
      String currentMedicamentName = patients[index]['medicamentName'] ?? '';
      String currentNumberOfDoses = patients[index]['numberOfDoses'] ?? '';
      String currentTimeFirstDose = patients[index]['timeFirstDose'] ?? '';
      String currentTimeSecondDose = patients[index]['timeSecondDose'] ?? '';
      String currentTimeThirdDose = patients[index]['timeThirdDose'] ?? '';
      String currentId = patients[index]['id'];

      // Controllers for text fields
      TextEditingController _nameController = TextEditingController(text: currentName);
      TextEditingController _statusController = TextEditingController(text: currentStatus);
      TextEditingController _roomNumberController = TextEditingController(text: currentRoomNumber);
      TextEditingController _ageController = TextEditingController(text: currentAge);
      TextEditingController _medicamentNameController = TextEditingController(text: currentMedicamentName);
      TextEditingController _numberOfDosesController = TextEditingController(text: currentNumberOfDoses);
      TextEditingController _timeOfFirstDoseController = TextEditingController(text: currentTimeFirstDose);
      TextEditingController _timeOfSecondDoseController = TextEditingController(text: currentTimeSecondDose);
      TextEditingController _timeOfThirdDoseController = TextEditingController(text: currentTimeThirdDose);

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
                        decoration: InputDecoration(labelText: 'Medicament name'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _numberOfDosesController,
                        decoration: InputDecoration(labelText: 'Number of doses'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfFirstDoseController,
                        decoration: InputDecoration(labelText: 'Time of first dose'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfSecondDoseController,
                        decoration: InputDecoration(labelText: 'Time of second dose'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfThirdDoseController,
                        decoration: InputDecoration(labelText: 'Time of third dose'),
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
                      String updatedRoomNumber = _roomNumberController.text.trim();
                      String updatedAge = _ageController.text.trim();
                      String updatedMedicamentName = _medicamentNameController.text.trim();
                      String updatedNumberOfDoses = _numberOfDosesController.text.trim();
                      String updatedTimeOfFirstDose = _timeOfFirstDoseController.text.trim();
                      String updatedTimeOfSecondDose = _timeOfSecondDoseController.text.trim();
                      String updatedTimeOfThirdDose = _timeOfThirdDoseController.text.trim();

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
                          patients[index]['medicamentName'] = updatedMedicamentName;
                          patients[index]['numberOfDoses'] = updatedNumberOfDoses;
                          patients[index]['timeFirstDose'] = updatedTimeOfFirstDose;
                          patients[index]['timeSecondDose'] = updatedTimeOfSecondDose;
                          patients[index]['timeThirdDose'] = updatedTimeOfThirdDose;
                        });
                        Navigator.of(context).pop(true); // Confirm update
                      } else {
                        // Show an error message or handle the case when any field is empty
                        print('All fields must be filled out');
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

      if (updateConfirmed == true) {
        // Patient updated successfully
        print('Patient updated successfully');
      } else {
        // Update canceled or failed
        print('Update canceled or failed');
      }
    } catch (e) {
      print('Failed to update patient: $e');
    }
  }

  Future<void> updatePatientData(
      String id,
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose,
      ) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      await patientsRef.doc(id).update({
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
      print('Patient data updated successfully');
    } catch (e) {
      print('Failed to update patient data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "مرضى وحدة غسيل الكلى",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: patients.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> patient = patients[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPatient(
                     // PatientId: patient['id'],
                      name: patient['name'] ?? '',
                      status: patient['status'] ?? '',
                      roomNumber: patient['roomNumber'] ?? '',
                      age: patient['age'] ?? '',
                      medicamentName: patient['medicamentName'] ?? '',
                      numberOfDoses: patient['numberOfDoses'] ?? '',
                      timeOfFirstDose: patient['timeFirstDose'] ?? '',
                      timeOfSecondDose: patient['timeSecondDose'] ?? '',
                      timeOfThirdDose: patient['timeThirdDose'] ?? '',
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Image.asset(
                    imagePatients[index % imagePatients.length],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(patient['name'] ?? 'Unknown'),
                  subtitle: Text(
                    'Status: ${patient['status'] ?? 'Unknown'}\n'
                        'Room number: ${patient['roomNumber'] ?? 'Unknown'}\n'
                        'Age: ${patient['age'] ?? 'Unknown'}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deletePatient(patient['id'], index),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          // Implement the action for adding a new patient
        },
      ),
      bottomNavigationBar: const ButtonNavBar(),
    );
  }
}
*/

//new

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
    retrievePatients(); // استدعاء استرجاع البيانات في initState
  }

  Future<void> retrievePatients() async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'] ?? '',
            'status': doc['status'] ?? '',
            'roomNumber': doc['roomNumber'] ?? '',
            'age': doc['age'] ?? '',
            'medicamentName': doc['medicamentName'] ?? '',
            'numberOfDoses': doc['numberOfDoses'] ?? '',
            'timeFirstDose': doc['timeFirstDose'] ?? '',
            'timeSecondDose': doc['timeSecondDose'] ?? '',
            'timeThirdDose': doc['timeThirdDose'] ?? '',
          };
        }).toList();
      });
      print('Patients retrieved successfully');
    } catch (e) {
      print('Failed to retrieve patients: $e');
    }
  }

  Future<dynamic> addNewPatient(
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose) async {
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
      String currentName = patients[index]['name'] ?? '';
      String currentStatus = patients[index]['status'] ?? '';
      String currentRoomNumber = patients[index]['roomNumber'] ?? '';
      String currentAge = patients[index]['age'] ?? '';
      String currentMedicamentName = patients[index]['medicamentName'] ?? '';
      String currentNumberOfDoses = patients[index]['numberOfDoses'] ?? '';
      String currentTimeFirstDose = patients[index]['timeFirstDose'] ?? '';
      String currentTimeSecondDose = patients[index]['timeSecondDose'] ?? '';
      String currentTimeThirdDose = patients[index]['timeThirdDose'] ?? '';
      String currentId = patients[index]['id'];

      // Controllers for text fields
      TextEditingController _nameController = TextEditingController(text: currentName);
      TextEditingController _statusController = TextEditingController(text: currentStatus);
      TextEditingController _roomNumberController = TextEditingController(text: currentRoomNumber);
      TextEditingController _ageController = TextEditingController(text: currentAge);
      TextEditingController _medicamentNameController = TextEditingController(text: currentMedicamentName);
      TextEditingController _numberOfDosesController = TextEditingController(text: currentNumberOfDoses);
      TextEditingController _timeOfFirstDoseController = TextEditingController(text: currentTimeFirstDose);
      TextEditingController _timeOfSecondDoseController = TextEditingController(text: currentTimeSecondDose);
      TextEditingController _timeOfThirdDoseController = TextEditingController(text: currentTimeThirdDose);

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
                        decoration: InputDecoration(labelText: 'Medicament name'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _numberOfDosesController,
                        decoration: InputDecoration(labelText: 'Number of doses'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfFirstDoseController,
                        decoration: InputDecoration(labelText: 'Time of first dose'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfSecondDoseController,
                        decoration: InputDecoration(labelText: 'Time of second dose'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfThirdDoseController,
                        decoration: InputDecoration(labelText: 'Time of third dose'),
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
                      String updatedRoomNumber = _roomNumberController.text.trim();
                      String updatedAge = _ageController.text.trim();
                      String updatedMedicamentName = _medicamentNameController.text.trim();
                      String updatedNumberOfDoses = _numberOfDosesController.text.trim();
                      String updatedTimeOfFirstDose = _timeOfFirstDoseController.text.trim();
                      String updatedTimeOfSecondDose = _timeOfSecondDoseController.text.trim();
                      String updatedTimeOfThirdDose = _timeOfThirdDoseController.text.trim();

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
                          patients[index]['medicamentName'] = updatedMedicamentName;
                          patients[index]['numberOfDoses'] = updatedNumberOfDoses;
                          patients[index]['timeFirstDose'] = updatedTimeOfFirstDose;
                          patients[index]['timeSecondDose'] = updatedTimeOfSecondDose;
                          patients[index]['timeThirdDose'] = updatedTimeOfThirdDose;
                        });
                        Navigator.of(context).pop(true); // Confirm update
                      } else {
                        // Show an error message if any field is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all fields.'),
                          ),
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

      if (updateConfirmed != null && updateConfirmed) {
        print('تم تحديث بيانات المريض بنجاح');
      } else {
        print('تم إلغاء تحديث بيانات المريض');
      }
    } catch (e) {
      print('فشل في تحديث بيانات المريض: $e');
    }
  }

  Future<void> updatePatientData(
      String id,
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose,
      ) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      await patientsRef.doc(id).update({
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

      // إعادة جلب البيانات من Firestore بعد العملية
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'] ?? '',
            'status': doc['status'] ?? '',
            'roomNumber': doc['roomNumber'] ?? '',
            'age': doc['age'] ?? '',
            'medicamentName': doc['medicamentName'] ?? '',
            'numberOfDoses': doc['numberOfDoses'] ?? '',
            'timeFirstDose': doc['timeFirstDose'] ?? '',
            'timeSecondDose': doc['timeSecondDose'] ?? '',
            'timeThirdDose': doc['timeThirdDose'] ?? '',
          };
        }).toList();
      });

      print('تم تحديث بيانات المريض بنجاح');
    } catch (e) {
      print('فشل في تحديث بيانات المريض: $e');
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
            padding: EdgeInsets.all(2),
            child: Card(
              elevation: 2,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPatient(
                        name: patients[index]['name'],
                        age: patients[index]['age'],
                        status: patients[index]['status'],
                        image: imagePatients[index % imagePatients.length],
                        roomNumber: patients[index]['roomNumber'],
                        medicamentName: patients[index]['medicamentName'],
                        numberOfDoses: patients[index]['numberOfDoses'],
                        timeOfFirstDose: patients[index]['timeFirstDose'],
                        timeOfSecondDose: patients[index]['timeSecondDose'],
                        timeOfThirdDose: patients[index]['timeThirdDose'],
                      ),
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: 'Name: ${patients[index]['name']}',
                      titleSize: 16,
                      titleFontWeight: FontWeight.bold,
                    ),
                    TextWidget(
                      title: 'Status: ${patients[index]['status']}',
                      titleSize: 16,
                      titleFontWeight: FontWeight.bold,
                    ),
                    TextWidget(
                      title: 'Room number: ${patients[index]['roomNumber']}',
                      titleSize: 16,
                      titleFontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          updatePatient(index);
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
            ),
          );
        },
      ),
      bottomNavigationBar: ButtonNavBar(initialIndex: 2),
    );
  }

}

class AddPatientDialog extends StatefulWidget {
  final Future<dynamic> Function(
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose) onAddPatient;

  AddPatientDialog({required this.onAddPatient});

  @override
  _AddPatientDialogState createState() => _AddPatientDialogState();
}

class _AddPatientDialogState extends State<AddPatientDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _medicamentNameController = TextEditingController();
  final TextEditingController _numberOfDosesController = TextEditingController();
  final TextEditingController _timeFirstDoseController = TextEditingController();
  final TextEditingController _timeSecondDoseController = TextEditingController();
  final TextEditingController _timeThirdDoseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    _roomNumberController.dispose();
    _ageController.dispose();
    _medicamentNameController.dispose();
    _numberOfDosesController.dispose();
    _timeFirstDoseController.dispose();
    _timeSecondDoseController.dispose();
    _timeThirdDoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Patient'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _roomNumberController,
                decoration: InputDecoration(labelText: 'Room number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _medicamentNameController,
                decoration: InputDecoration(labelText: 'Medicament name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a medicament name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _numberOfDosesController,
                decoration: InputDecoration(labelText: 'Number of doses'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of doses';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeFirstDoseController,
                decoration: InputDecoration(labelText: 'Time of first dose'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time of first dose';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeSecondDoseController,
                decoration: InputDecoration(labelText: 'Time of second dose'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time of second dose';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeThirdDoseController,
                decoration: InputDecoration(labelText: 'Time of third dose'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time of third dose';
                  }
                  return null;
                },
              ),
            ],
          ),
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await widget.onAddPatient(
                _nameController.text.trim(),
                _statusController.text.trim(),
                _roomNumberController.text.trim(),
                _ageController.text.trim(),
                _medicamentNameController.text.trim(),
                _numberOfDosesController.text.trim(),
                _timeFirstDoseController.text.trim(),
                _timeSecondDoseController.text.trim(),
                _timeThirdDoseController.text.trim(),
              );
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}


*/



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
    retrievePatients(); // استدعاء استرجاع البيانات في initState
  }

  Future<void> retrievePatients() async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'] ?? '',
            'status': doc['status'] ?? '',
            'roomNumber': doc['roomNumber'] ?? '',
            'age': doc['age'] ?? '',
            'medicamentName': doc['medicamentName'] ?? '',
            'numberOfDoses': doc['numberOfDoses'] ?? '',
            'timeFirstDose': doc['timeFirstDose'] ?? '',
            'timeSecondDose': doc['timeSecondDose'] ?? '',
            'timeThirdDose': doc['timeThirdDose'] ?? '',
          };
        }).toList();
      });
      print('Patients retrieved successfully');
    } catch (e) {
      print('Failed to retrieve patients: $e');
    }
  }

  Future<dynamic> addNewPatient(
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose) async {
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
      String currentName = patients[index]['name'] ?? '';
      String currentStatus = patients[index]['status'] ?? '';
      String currentRoomNumber = patients[index]['roomNumber'] ?? '';
      String currentAge = patients[index]['age'] ?? '';
      String currentMedicamentName = patients[index]['medicamentName'] ?? '';
      String currentNumberOfDoses = patients[index]['numberOfDoses'] ?? '';
      String currentTimeFirstDose = patients[index]['timeFirstDose'] ?? '';
      String currentTimeSecondDose = patients[index]['timeSecondDose'] ?? '';
      String currentTimeThirdDose = patients[index]['timeThirdDose'] ?? '';
      String currentId = patients[index]['id'];

      // Controllers for text fields
      TextEditingController _nameController = TextEditingController(text: currentName);
      TextEditingController _statusController = TextEditingController(text: currentStatus);
      TextEditingController _roomNumberController = TextEditingController(text: currentRoomNumber);
      TextEditingController _ageController = TextEditingController(text: currentAge);
      TextEditingController _medicamentNameController = TextEditingController(text: currentMedicamentName);
      TextEditingController _numberOfDosesController = TextEditingController(text: currentNumberOfDoses);
      TextEditingController _timeOfFirstDoseController = TextEditingController(text: currentTimeFirstDose);
      TextEditingController _timeOfSecondDoseController = TextEditingController(text: currentTimeSecondDose);
      TextEditingController _timeOfThirdDoseController = TextEditingController(text: currentTimeThirdDose);

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
                        decoration: InputDecoration(labelText: 'Medicament name'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _numberOfDosesController,
                        decoration: InputDecoration(labelText: 'Number of doses'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfFirstDoseController,
                        decoration: InputDecoration(labelText: 'Time of first dose'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfSecondDoseController,
                        decoration: InputDecoration(labelText: 'Time of second dose'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfThirdDoseController,
                        decoration: InputDecoration(labelText: 'Time of third dose'),
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
                      String updatedRoomNumber = _roomNumberController.text.trim();
                      String updatedAge = _ageController.text.trim();
                      String updatedMedicamentName = _medicamentNameController.text.trim();
                      String updatedNumberOfDoses = _numberOfDosesController.text.trim();
                      String updatedTimeOfFirstDose = _timeOfFirstDoseController.text.trim();
                      String updatedTimeOfSecondDose = _timeOfSecondDoseController.text.trim();
                      String updatedTimeOfThirdDose = _timeOfThirdDoseController.text.trim();

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
                          patients[index]['medicamentName'] = updatedMedicamentName;
                          patients[index]['numberOfDoses'] = updatedNumberOfDoses;
                          patients[index]['timeFirstDose'] = updatedTimeOfFirstDose;
                          patients[index]['timeSecondDose'] = updatedTimeOfSecondDose;
                          patients[index]['timeThirdDose'] = updatedTimeOfThirdDose;
                        });
                        Navigator.of(context).pop(true); // Confirm update
                      } else {
                        // Show an error message if any field is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all fields.'),
                          ),
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

      if (updateConfirmed != null && updateConfirmed) {
        print('تم تحديث بيانات المريض بنجاح');
      } else {
        print('تم إلغاء تحديث بيانات المريض');
      }
    } catch (e) {
      print('فشل في تحديث بيانات المريض: $e');
    }
  }

  Future<void> updatePatientData(
      String id,
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose,
      ) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      await patientsRef.doc(id).update({
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

      // إعادة جلب البيانات من Firestore بعد العملية
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'] ?? '',
            'status': doc['status'] ?? '',
            'roomNumber': doc['roomNumber'] ?? '',
            'age': doc['age'] ?? '',
            'medicamentName': doc['medicamentName'] ?? '',
            'numberOfDoses': doc['numberOfDoses'] ?? '',
            'timeFirstDose': doc['timeFirstDose'] ?? '',
            'timeSecondDose': doc['timeSecondDose'] ?? '',
            'timeThirdDose': doc['timeThirdDose'] ?? '',
          };
        }).toList();
      });

      print('تم تحديث بيانات المريض بنجاح');
    } catch (e) {
      print('فشل في تحديث بيانات المريض: $e');
    }
  }

    //
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
            icon: Container(decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only(topRight: Radius.circular(3),
            topLeft:  Radius.circular(3),bottomLeft:  Radius.circular(3),bottomRight:  Radius.circular(3))),
                width:50,height: 50,child: Icon(Icons.add,color: Colors.white,)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(2),
            child: Card(
              elevation: 2,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPatient(
                        name: patients[index]['name'],
                        age: patients[index]['age'],
                        status: patients[index]['status'],
                        image: imagePatients[index % imagePatients.length],
                        roomNumber: patients[index]['roomNumber'],
                        medicamentName: patients[index]['medicamentName'],
                        numberOfDoses: patients[index]['numberOfDoses'],
                        timeOfFirstDose: patients[index]['timeFirstDose'],
                        timeOfSecondDose: patients[index]['timeSecondDose'],
                        timeOfThirdDose: patients[index]['timeThirdDose'],
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imagePatients[index % imagePatients.length]),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: 'Name: ${patients[index]['name']}',
                      titleSize: 16,
                      titleFontWeight: FontWeight.bold,
                    ),
                    TextWidget(
                      title: 'Status: ${patients[index]['status']}',
                      titleSize: 16,
                      titleFontWeight: FontWeight.bold,
                    ),
                    TextWidget(
                      title: 'Room number: ${patients[index]['roomNumber']}',
                      titleSize: 16,
                      titleFontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          updatePatient(index);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deletePatient(patients[index]['id'], index);
                        },
                        icon: Icon(Icons.delete,color: Colors.red,),
                      ),
                    ],
                  ),
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

class AddPatientDialog extends StatefulWidget {
  final Future<dynamic> Function(
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose) onAddPatient;

  AddPatientDialog({required this.onAddPatient});

  @override
  _AddPatientDialogState createState() => _AddPatientDialogState();
}

class _AddPatientDialogState extends State<AddPatientDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _medicamentNameController = TextEditingController();
  final TextEditingController _numberOfDosesController = TextEditingController();
  final TextEditingController _timeFirstDoseController = TextEditingController();
  final TextEditingController _timeSecondDoseController = TextEditingController();
  final TextEditingController _timeThirdDoseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    _roomNumberController.dispose();
    _ageController.dispose();
    _medicamentNameController.dispose();
    _numberOfDosesController.dispose();
    _timeFirstDoseController.dispose();
    _timeSecondDoseController.dispose();
    _timeThirdDoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Patient'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _roomNumberController,
                decoration: InputDecoration(labelText: 'Room number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _medicamentNameController,
                decoration: InputDecoration(labelText: 'Medicament name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a medicament name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _numberOfDosesController,
                decoration: InputDecoration(labelText: 'Number of doses'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of doses';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeFirstDoseController,
                decoration: InputDecoration(labelText: 'Time of first dose'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time of first dose';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeSecondDoseController,
                decoration: InputDecoration(labelText: 'Time of second dose'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time of second dose';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeThirdDoseController,
                decoration: InputDecoration(labelText: 'Time of third dose'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time of third dose';
                  }
                  return null;
                },
              ),
            ],
          ),
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await widget.onAddPatient(
                _nameController.text.trim(),
                _statusController.text.trim(),
                _roomNumberController.text.trim(),
                _ageController.text.trim(),
                _medicamentNameController.text.trim(),
                _numberOfDosesController.text.trim(),
                _timeFirstDoseController.text.trim(),
                _timeSecondDoseController.text.trim(),
                _timeThirdDoseController.text.trim(),
              );
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}




*/



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
    retrievePatients(); // استدعاء استرجاع البيانات في initState
  }

  Future<void> retrievePatients() async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      QuerySnapshot querySnapshot = await patientsRef.get();
      setState(() {
        patients = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'] ?? '',
            'status': doc['status'] ?? '',
            'roomNumber': doc['roomNumber'] ?? '',
            'age': doc['age'] ?? '',
            'medicamentName': doc['medicamentName'] ?? '',
            'numberOfDoses': doc['numberOfDoses'] ?? '',
            'timeFirstDose': doc['timeFirstDose'] ?? '',
            'timeSecondDose': doc['timeSecondDose'] ?? '',
            'timeThirdDose': doc['timeThirdDose'] ?? '',
          };
        }).toList();
      });
      print('Patients retrieved successfully');
    } catch (e) {
      print('Failed to retrieve patients: $e');
    }
  }

  Future<dynamic> addNewPatient(
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose) async {
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
      String currentName = patients[index]['name'] ?? '';
      String currentStatus = patients[index]['status'] ?? '';
      String currentRoomNumber = patients[index]['roomNumber'] ?? '';
      String currentAge = patients[index]['age'] ?? '';
      String currentMedicamentName = patients[index]['medicamentName'] ?? '';
      String currentNumberOfDoses = patients[index]['numberOfDoses'] ?? '';
      String currentTimeFirstDose = patients[index]['timeFirstDose'] ?? '';
      String currentTimeSecondDose = patients[index]['timeSecondDose'] ?? '';
      String currentTimeThirdDose = patients[index]['timeThirdDose'] ?? '';
      String currentId = patients[index]['id'];

      // Controllers for text fields
      TextEditingController _nameController = TextEditingController(text: currentName);
      TextEditingController _statusController = TextEditingController(text: currentStatus);
      TextEditingController _roomNumberController = TextEditingController(text: currentRoomNumber);
      TextEditingController _ageController = TextEditingController(text: currentAge);
      TextEditingController _medicamentNameController = TextEditingController(text: currentMedicamentName);
      TextEditingController _numberOfDosesController = TextEditingController(text: currentNumberOfDoses);
      TextEditingController _timeOfFirstDoseController = TextEditingController(text: currentTimeFirstDose);
      TextEditingController _timeOfSecondDoseController = TextEditingController(text: currentTimeSecondDose);
      TextEditingController _timeOfThirdDoseController = TextEditingController(text: currentTimeThirdDose);

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
                        decoration: InputDecoration(labelText: 'Medicament name'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _numberOfDosesController,
                        decoration: InputDecoration(labelText: 'Number of doses'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfFirstDoseController,
                        decoration: InputDecoration(labelText: 'Time of first dose'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfSecondDoseController,
                        decoration: InputDecoration(labelText: 'Time of second dose'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _timeOfThirdDoseController,
                        decoration: InputDecoration(labelText: 'Time of third dose'),
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
                      String updatedRoomNumber = _roomNumberController.text.trim();
                      String updatedAge = _ageController.text.trim();
                      String updatedMedicamentName = _medicamentNameController.text.trim();
                      String updatedNumberOfDoses = _numberOfDosesController.text.trim();
                      String updatedTimeOfFirstDose = _timeOfFirstDoseController.text.trim();
                      String updatedTimeOfSecondDose = _timeOfSecondDoseController.text.trim();
                      String updatedTimeOfThirdDose = _timeOfThirdDoseController.text.trim();

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
                          patients[index]['medicamentName'] = updatedMedicamentName;
                          patients[index]['numberOfDoses'] = updatedNumberOfDoses;
                          patients[index]['timeFirstDose'] = updatedTimeOfFirstDose;
                          patients[index]['timeSecondDose'] = updatedTimeOfSecondDose;
                          patients[index]['timeThirdDose'] = updatedTimeOfThirdDose;
                        });

                        Navigator.of(context).pop(true); // Confirm update
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

      if (updateConfirmed ?? false) {
        print('Patient updated successfully');
      } else {
        print('Patient update cancelled');
      }
    } catch (e) {
      print('Failed to update patient: $e');
    }
  }

  Future<void> updatePatientData(
      String id,
      String name,
      String status,
      String roomNumber,
      String age,
      String medicamentName,
      String numberOfDoses,
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose,
      ) async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('patients');
      await patientsRef.doc(id).update({
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
      print('Patient data updated successfully');
    } catch (e) {
      print('Failed to update patient data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients of Blood Pressure ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const ButtonNavBar(),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          final imagePath = imagePatients[index % imagePatients.length];
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 30.0,
              ),
              title: Text(patient['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status: ${patient['status'] ?? ''}'),
                  Text('Room Number: ${patient['roomNumber'] ?? ''}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => updatePatient(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deletePatient(patient['id'], index),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPatient(
                      name: patient['name'] ?? '',
                      status: patient['status'] ?? '',
                      roomNumber: patient['roomNumber'] ?? '',
                      age: patient['age'] ?? '',
                      medicamentName: patient['medicamentName'] ?? '',
                      numberOfDoses: patient['numberOfDoses'] ?? '',
                      timeOfFirstDose: patient['timeFirstDose'] ?? '',
                      timeOfSecondDose: patient['timeSecondDose'] ?? '',
                      timeOfThirdDose: patient['timeThirdDose'] ?? '',
                      image: imagePatients[index % imagePatients.length],
                    ),
                  ),
                );
              },
            ),
          );
        },
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
      String timeFirstDose,
      String timeSecondDose,
      String timeThirdDose,
      ) onAddPatient;

  AddPatientDialog({required this.onAddPatient});

  @override
  _AddPatientDialogState createState() => _AddPatientDialogState();
}

class _AddPatientDialogState extends State<AddPatientDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _roomNumberController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _medicamentNameController = TextEditingController();
  TextEditingController _numberOfDosesController = TextEditingController();
  TextEditingController _timeOfFirstDoseController = TextEditingController();
  TextEditingController _timeOfSecondDoseController = TextEditingController();
  TextEditingController _timeOfThirdDoseController = TextEditingController();

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
              decoration: InputDecoration(labelText: 'Medicament name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _numberOfDosesController,
              decoration: InputDecoration(labelText: 'Number of doses'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _timeOfFirstDoseController,
              decoration: InputDecoration(labelText: 'Time of first dose'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _timeOfSecondDoseController,
              decoration: InputDecoration(labelText: 'Time of second dose'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _timeOfThirdDoseController,
              decoration: InputDecoration(labelText: 'Time of third dose'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cancel adding new patient
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String name = _nameController.text.trim();
            String status = _statusController.text.trim();
            String roomNumber = _roomNumberController.text.trim();
            String age = _ageController.text.trim();
            String medicamentName = _medicamentNameController.text.trim();
            String numberOfDoses = _numberOfDosesController.text.trim();
            String timeFirstDose = _timeOfFirstDoseController.text.trim();
            String timeSecondDose = _timeOfSecondDoseController.text.trim();
            String timeThirdDose = _timeOfThirdDoseController.text.trim();

            if (name.isNotEmpty &&
                status.isNotEmpty &&
                roomNumber.isNotEmpty &&
                age.isNotEmpty &&
                medicamentName.isNotEmpty &&
                numberOfDoses.isNotEmpty &&
                timeFirstDose.isNotEmpty &&
                timeSecondDose.isNotEmpty &&
                timeThirdDose.isNotEmpty) {
              widget.onAddPatient(
                name,
                status,
                roomNumber,
                age,
                medicamentName,
                numberOfDoses,
                timeFirstDose,
                timeSecondDose,
                timeThirdDose,
              );
              Navigator.of(context).pop(); // Confirm adding new patient
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}









