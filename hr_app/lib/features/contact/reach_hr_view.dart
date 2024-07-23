import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReachHRScreen extends StatefulWidget {
  const ReachHRScreen({super.key});

  @override
  ReachHRScreenState createState() => ReachHRScreenState();
}

class ReachHRScreenState extends State<ReachHRScreen> {
  final _formKey = GlobalKey<FormState>();
  final _leaveFormKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _reasonController = TextEditingController();
  String? _selectedProject;
  DateTime? _startDate;
  int? _numOfDays;
  final String _status = 'Pending';

  final List<String> projects = ['Project A', 'Project B', 'Project C'];

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _sendEmail() {
    if (_formKey.currentState!.validate()) {
      // Implement email sending logic here
      print('Sending email to HR for $_selectedProject');
      print('Subject: ${_subjectController.text}');
      print('Message: ${_messageController.text}');
    }
  }

  void _submitLeaveRequest() {
    if (_leaveFormKey.currentState!.validate()) {
      // Implement leave request submission logic here
      print('Submitting leave request');
      print('Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate!)}');
      print('Number of Days: $_numOfDays');
      print('Reason: ${_reasonController.text}');
      print('Status: $_status');
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reach HR'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send Email to HR',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedProject,
                      hint: const Text('Select Project'),
                      items: projects.map((String project) {
                        return DropdownMenuItem<String>(
                          value: project,
                          child: Text(project),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedProject = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) =>
                      value == null ? 'Please select a project' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a subject' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLines: 5,
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a message' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _sendEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: const Text(
                        'Send Email',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Submit Leave Request',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _leaveFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectStartDate(context),
                        ),
                      ),
                      controller: TextEditingController(
                        text: _startDate == null
                            ? ''
                            : DateFormat('yyyy-MM-dd').format(_startDate!),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please select a start date' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number of Days',
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        _numOfDays = int.tryParse(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter number of days';
                        } else if (int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Please enter a valid number of days';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _reasonController,
                      decoration: InputDecoration(
                        labelText: 'Reason',
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLines: 3,
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a reason' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitLeaveRequest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: const Text(
                        'Submit Leave Request',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
