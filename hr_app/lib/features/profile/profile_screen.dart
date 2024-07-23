import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'John Doe';
  String email = 'johndoe@example.com';
  String phone = '+1 234 567 890';
  String address = '123 Main Street, Springfield, USA';
  DateTime birthday = DateTime(1990, 1, 1);
  DateTime joinDate = DateTime(2020, 5, 1);
  String position = 'Software Engineer';
  double salary = 75000;
  String status = 'Active';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = name;
    _emailController.text = email;
    _phoneController.text = phone;
    _addressController.text = address;
    _birthdayController.text = DateFormat('yyyy-MM-dd').format(birthday);
    _joinDateController.text = DateFormat('yyyy-MM-dd').format(joinDate);
    _positionController.text = position;
    _salaryController.text = salary.toString();
    _statusController.text = status;
  }

  void _updateProfile() {
    setState(() {
      name = _nameController.text;
      email = _emailController.text;
      phone = _phoneController.text;
      address = _addressController.text;
      birthday = DateFormat('yyyy-MM-dd').parse(_birthdayController.text);
      joinDate = DateFormat('yyyy-MM-dd').parse(_joinDateController.text);
      position = _positionController.text;
      salary = double.tryParse(_salaryController.text) ?? salary;
      status = _statusController.text;
    });
    Navigator.of(context).pop();
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Name', _nameController),
                _buildTextField('Email', _emailController),
                _buildTextField('Phone', _phoneController),
                _buildTextField('Address', _addressController),
                _buildTextField('Birthday (yyyy-MM-dd)', _birthdayController),
                _buildTextField('Join Date (yyyy-MM-dd)', _joinDateController),
                _buildTextField('Position', _positionController),
                _buildTextField('Salary', _salaryController),
                _buildTextField('Status', _statusController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Placeholder image
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Divider(),
              _buildProfileItem('Phone', phone),
              _buildProfileItem('Address', address),
              _buildProfileItem('Birthday', DateFormat('yyyy-MM-dd').format(birthday)),
              _buildProfileItem('Join Date', DateFormat('yyyy-MM-dd').format(joinDate)),
              _buildProfileItem('Position', position),
              _buildProfileItem('Salary', '\$${salary.toStringAsFixed(2)}'),
              _buildProfileItem('Status', status),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque arcu id neque congue, in pharetra ex condimentum.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
