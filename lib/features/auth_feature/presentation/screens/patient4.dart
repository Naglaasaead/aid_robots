

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/widgets/text_widget.dart';
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

  @override
  void initState() {
    super.initState();
    retrievePatients(); // استدعاء استرجاع البيانات في initState
  }

  Future<void> retrievePatients() async {
    try {
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient3');
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
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient3');
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
      CollectionReference patientsRef = FirebaseFirestore.instance.collection('docPatient3');
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
        title: const Text('Patients'),
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









