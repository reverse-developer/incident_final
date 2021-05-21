import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incident_report/helpers/toast.dart';
import 'package:incident_report/services/global.dart';
import 'package:incident_report/styles/styles.dart';
import 'package:incident_report/utils/size_config.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  // ADD YOUR CREDENTIALS HERE DONT FORGET TO ENABLE LESS SECRURE APPS IN GOOGLE GMAIL
  String username = 'email';
  String password = 'password';

  sendMail(name, data, date) async {
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, '${name}')
      ..recipients.add(
          'tadmilmine74@hotmail.com') // EMAIL YOU WANT TO SEND THE MAILS TO
      ..subject = 'NEW REPORT FROM ${name}'
      ..html =
          '<h1>Incident Report</h1>\n<p>Details : </p>\n<p>Name : ${data['name']} </p>\n<p>City : ${data['city']} </p>\n<p>Email : ${data['email']} </p>\n<img src=${data['picture']}/>\n<p>Date : ${DateFormat('yyyy-MM-dd').format(date)} -- ${data['hour']}:${data['minutes']} </p>\n<p>Description : ${data['description']} </p>';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  // END MAIL
  final _formKey = GlobalKey<FormState>();
  String cityValue = "Toronto";

  List<DropdownMenuItem> kCities = [
    DropdownMenuItem(
      child: Text('Toronto'),
      value: 'Toronto',
    ),
    DropdownMenuItem(
      child: Text('Montreal'),
      value: 'Montreal',
    )
  ];

  List<String> cityValues = ['Toronto', 'Montreal'];

  TextEditingController _email = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _min = TextEditingController();
  TextEditingController _hour = TextEditingController();
  TextEditingController _description = TextEditingController();

  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected =
    await ImagePicker().getImage(source: source, imageQuality: 70);

    setState(() {
      if (selected != null) {
        _imageFile = File(selected.path);
      } else {
        print('No image selected.');
      }
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
      bucket: 'gs://incident-report-can.appspot.com');

  UploadTask _uploadTask;

  Future<String> _startUpload() async {
    String filePath = 'images/${DateTime.now()}.png';
    _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);

    final snapshot = (await _uploadTask);
    String url = await snapshot.ref.getDownloadURL(); // await
    return url;
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xff2A2626),
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/full.png',
                            height: 15.66 * SizeConfig.imageSizeMultiplier,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Incident Report Form',
                        style: BigBoldFormHeading,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'Please include as much detail as possible in the form',
                      style: FormGreySubtitle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _firstName,
                      autofillHints: [
                        AutofillHints.name,
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Name',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Field required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _city,
                      autofillHints: [
                        AutofillHints.name,
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        hintText: 'City',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Field required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _email,
                      autofillHints: [
                        AutofillHints.email,
                      ],
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                      validator: (String value) {
                        if (value == '') {
                          return 'Field required';
                        }
                        if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value)) {
                          return 'Please enter correct email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          _pickImage(
                            ImageSource.gallery,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: new SizedBox(
                              width: 78.0,
                              height: 78.0,
                              child: (_imageFile != null)
                                  ? Image.file(
                                _imageFile,
                                fit: BoxFit.fill,
                              )
                                  : Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.camera_alt,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 60,
                          width: 30.37 * SizeConfig.widthMultiplier,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _hour,
                            autofillHints: [
                              AutofillHints.name,
                            ],
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.timer,
                              ),
                              hintText: 'Hour',
                            ),
                            validator: (value) {
                              if (value == '') {
                                return 'Field required';
                              }
                              return null;
                            },
                          ),
                        ),
                        // Container(
                        //   height: 60,
                        //   width: 18.75 * SizeConfig.widthMultiplier,
                        //   child: TextFormField(
                        //     keyboardType: TextInputType.number,
                        //     inputFormatters: <TextInputFormatter>[
                        //       FilteringTextInputFormatter.digitsOnly
                        //     ],
                        //     controller: _min,
                        //     autofillHints: [
                        //       AutofillHints.name,
                        //     ],
                        //     decoration: InputDecoration(
                        //       hintText: 'Min',
                        //     ),
                        //     validator: (value) {
                        //       if (value == '') {
                        //         return 'Field required';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            height: 60,
                            width: 40 * SizeConfig.widthMultiplier,
                            decoration: BoxDecoration(
                              color: InputFieldGrey,
                              borderRadius: buttonBorderRadius,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: _description,
                      autofillHints: [
                        AutofillHints.name,
                      ],
                      decoration: InputDecoration(
                        hintText:
                        'Describe the issue her \n\nCan you think of anyone else who saw this? \nWhat was the person wearing?',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Field required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    loading == true
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: RaisedButton(
                          elevation: 0,
                          textColor: Colors.white,
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });

                            if (!_formKey.currentState.validate()) {
                              setState(() {
                                loading = false;
                              });
                              return;
                            }

// uploading the image

                            var url = await _startUpload();

                            var data = {
                              "name": _firstName.text,
                              "city": _city.text,
                              "email": _email.text,
                              "picture": url,
                              "hour": _hour.text,
                              "description": _description.text
                            };

                            // login

                            var result =
                            await Global.reportRef.upsert(data);

                            if (result == null) {
                              print('ERROR SENDING');
                              setState(() {
                                loading = false;
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });

                              sendMail(
                                  _firstName.text, data, selectedDate);

                              toast('Report sent');

                              // Navigator.pop(context);

                              Navigator.pop(context);
                            }

                            setState(() {
                              loading = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text('SUBMIT'),
                              Icon(Icons.exit_to_app)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
