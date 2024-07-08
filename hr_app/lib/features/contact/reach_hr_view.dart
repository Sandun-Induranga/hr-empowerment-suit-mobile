import 'package:flutter/material.dart';

class ReachHRScreen extends StatefulWidget {
  const ReachHRScreen({super.key});

  @override
  ReachHRScreenState createState() => ReachHRScreenState();
}

class ReachHRScreenState extends State<ReachHRScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String? _selectedProject;
  String? _selectedRecipient;

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
                'HR Notices',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildHRNotice('Company meeting on Friday at 10 AM'),
              _buildHRNotice('Submit your project reports by end of the month'),
              const SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHRNotice(String notice) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(notice),
      ),
    );
  }
}
