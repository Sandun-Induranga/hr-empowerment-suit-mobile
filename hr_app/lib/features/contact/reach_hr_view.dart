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
  String? _selectedRecipient;
  DateTime? _startDate;
  int? _numOfDays;
  final String _status = 'Pending';

  final List<String> projects = ['Project A', 'Project B', 'Project C'];
  final List<String> recipients = [
    'HR',
    'All Project Members',
    'Project Manager',
    'Company Members'
  ];

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
      print('Sending email to $_selectedRecipient for $_selectedProject');
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send Emails',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
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
                      validator: (value) =>
                      value == null ? 'Please select a project' : null,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedRecipient,
                      hint: const Text('Select Recipient'),
                      items: recipients.map((String recipient) {
                        return DropdownMenuItem<String>(
                          value: recipient,
                          child: Text(recipient),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRecipient = newValue;
                        });
                      },
                      validator: (value) =>
                      value == null ? 'Please select a recipient' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a subject' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a message' : null,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _sendEmail,
                      child: const Text('Send Email'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Submit Leave Request',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Form(
                key: _leaveFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        border: OutlineInputBorder(),
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
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Number of Days',
                        border: OutlineInputBorder(),
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _reasonController,
                      decoration: const InputDecoration(
                        labelText: 'Reason',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a reason' : null,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _submitLeaveRequest,
                      child: const Text('Submit Leave Request'),
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
