import 'package:flutter/material.dart';

void main() {
  runApp(ContactForm());
}

class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();

  String? _gender;
  String _contactMethod = 'Email';
  bool _subscribed = false;
  String _submittedResult = '';
  String _errorMessage = '';

  void _submitContact() {
    setState(() {
      _errorMessage = '';
    });

    if (_name.text.isEmpty || _email.text.isEmpty || _gender == null) {
      setState(() {
        _errorMessage = 'Please fill out all fields';
      });
      return;
    }

    if (!_email.text.contains('@') || !_email.text.contains('.')) {
      setState(() {
        _errorMessage = 'Please enter a valid email format';
      });
      return;
    }

    setState(() {
      _submittedResult =
      'Name: ${_name.text}\nEmail: ${_email.text}\nGender: $_gender\nPreferred Contact Method: $_contactMethod\nSubscribed: ${_subscribed ? 'Yes' : 'No'}';
      _errorMessage = '';
    });
  }

  void _clearContact() {
    setState(() {
      _name.clear();
      _email.clear();
      _gender = null;
      _contactMethod = 'Email';
      _subscribed = false;
      _submittedResult = '';
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Form',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Gender:'),
              Row(
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  Text('Male'),
                  Radio(
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  Text('Female'),
                  Radio(
                    value: 'Other',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  Text('Other'),
                ],
              ),
              SizedBox(height: 20),
              Text('Preferred Contact Method:'),
              DropdownButton<String>(
                value: _contactMethod,
                items: ['Email', 'Phone', 'SMS']
                    .map((cm) => DropdownMenuItem(
                  value: cm,
                  child: Text(cm),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _contactMethod = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _subscribed,
                    onChanged: (value) {
                      setState(() {
                        _subscribed = value!;
                      });
                    },
                  ),
                  Text('Subscribe to newsletter'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _submitContact,
                    child: Text('Submit'),
                  ),
                  ElevatedButton(
                    onPressed: _clearContact,
                    child: Text('Clear'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _errorMessage.isNotEmpty
                  ? Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 14),
              )
                  : SizedBox.shrink(),
              SizedBox(height: 20),
              _submittedResult.isNotEmpty
                  ? Text(
                _submittedResult,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

