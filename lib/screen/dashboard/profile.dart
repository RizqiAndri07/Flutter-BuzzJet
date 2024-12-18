import 'package:flutter/material.dart';
import '../../service/ProfileService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileService _profileService = ProfileService();
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  String? _error;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final data = await _profileService.getProfile();

      setState(() {
        _profileData = data;
        _nameController.text = data['name'];
        _emailController.text = data['email'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfile() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      _showMessage('Name and Email must be filled');
      return;
    }

    try {
      setState(() => _isLoading = true);
      await _profileService.updateProfile(_profileData!['id'], name, email);
      _showMessage('Profile updated successfully');
      _loadProfile();
    } catch (e) {
      _showMessage('Failed to update profile: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            ElevatedButton(
              onPressed: _loadProfile,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_profileData == null) {
      return Center(child: Text('No profile data available'));
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              child: Text(
                _profileData!['name']?[0] ?? '?',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildProfileItem('Name', _nameController),
          _buildProfileItem('Email', _emailController),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
