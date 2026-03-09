import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../presentation/providers/auth_providers.dart';
import '../domain/entities/user/user.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isEditing = false;
  bool _isSaving = false;

  // Controllers for editing
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;

  // Current user data
  User? _currentUser;
  bool _isLoading = true;

  // Validation errors
  String? _fullNameError;
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
    _fetchCurrentUser();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _fetchCurrentUser() async {
    setState(() {
      _isLoading = true;
    });

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.getCurrentUser();

    if (mounted) {
      result.fold(
        (failure) {
          setState(() {
            _isLoading = false;
          });
          _showErrorSnackBar('Failed to load profile: ${failure.toString()}');
        },
        (user) {
          if (user != null) {
            setState(() {
              _currentUser = user;
              _isLoading = false;
              _fullNameController.text = user.fullName;
              _phoneController.text = user.phoneNumber ?? '';
            });
          } else {
            setState(() {
              _isLoading = false;
            });
            _showErrorSnackBar('No user logged in');
          }
        },
      );
    }
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter full name';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }
    final cleanedPhone = value.replaceAll(RegExp(r'[\s-]'), '');
    if (cleanedPhone.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanedPhone)) {
      return 'Please enter valid phone number';
    }
    return null;
  }

  bool _validateForm() {
    setState(() {
      _fullNameError = null;
      _phoneError = null;
    });

    bool isValid = true;
    final fullNameError = _validateFullName(_fullNameController.text);
    final phoneError = _validatePhone(_phoneController.text);

    if (fullNameError != null) {
      setState(() {
        _fullNameError = fullNameError;
      });
      isValid = false;
    }

    if (phoneError != null) {
      setState(() {
        _phoneError = phoneError;
      });
      isValid = false;
    }

    return isValid;
  }

  Future<void> _saveProfile() async {
    if (!_validateForm()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.updateProfile(
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
    );

    if (mounted) {
      result.fold(
        (failure) {
          setState(() {
            _isSaving = false;
          });
          _showErrorSnackBar('Failed to update profile: ${failure.toString()}');
        },
        (updatedUser) {
          setState(() {
            _currentUser = updatedUser;
            _isSaving = false;
            _isEditing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
      );
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _fullNameError = null;
      _phoneError = null;
      // Reset to original values
      if (_currentUser != null) {
        _fullNameController.text = _currentUser!.fullName;
        _phoneController.text = _currentUser!.phoneNumber ?? '';
      }
    });
  }

  void _startEdit() {
    setState(() {
      _isEditing = true;
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String _formatDateTime(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF8B0000),
          elevation: 2,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF8B0000),
          elevation: 2,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.account_circle, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No profile data available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF8B0000),
        elevation: 2,
        actions: [
          if (_isEditing)
            Row(
              children: [
                TextButton(
                  onPressed: _isSaving ? null : _cancelEdit,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF8B0000),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _isSaving ? null : _saveProfile,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF8B0000),
                          ),
                        )
                      : const Icon(
                          Icons.check,
                          color: Color(0xFF8B0000),
                        ),
                ),
              ],
            )
          else
            IconButton(
              onPressed: _startEdit,
              icon: const Icon(
                Icons.edit,
                color: Color(0xFF8B0000),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header with Avatar
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF8B0000).withValues(alpha: 0.1),
                    child: Text(
                      _currentUser!.initials,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B0000),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Text(
                    _currentUser!.fullName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B0000),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Email with verification status
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _currentUser!.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      if (_currentUser!.emailVerified)
                        const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.verified,
                            size: 16,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            const Divider(height: 32),

            // Full Name Field
            _buildFieldSection(
              icon: Icons.person_outline,
              label: 'Full Name',
              isReadOnly: !_isEditing,
              controller: _fullNameController,
              errorText: _fullNameError,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: 16),

            // Email Field (Read-only)
            _buildFieldSection(
              icon: Icons.email_outlined,
              label: 'Email',
              isReadOnly: true,
              controller: TextEditingController(text: _currentUser!.email),
              errorText: null,
            ),

            const SizedBox(height: 16),

            // Phone Number Field
            _buildFieldSection(
              icon: Icons.phone_outlined,
              label: 'Phone Number',
              isReadOnly: !_isEditing,
              controller: _phoneController,
              errorText: _phoneError,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
            ),

            const SizedBox(height: 16),

            // Member Since (Read-only)
            _buildReadOnlyField(
              icon: Icons.calendar_today_outlined,
              label: 'Member Since',
              value: _formatDate(_currentUser!.createdAt),
            ),

            const SizedBox(height: 16),

            // Last Login (Read-only)
            _buildReadOnlyField(
              icon: Icons.access_time_outlined,
              label: 'Last Login',
              value: _formatDateTime(_currentUser!.lastLoginAt),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldSection({
    required IconData icon,
    required String label,
    required bool isReadOnly,
    TextEditingController? controller,
    String? errorText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: errorText != null ? Colors.red : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B0000),
              ),
            ),
          ),
          // Field
          if (isReadOnly)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      controller?.text ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              decoration: InputDecoration(
                hintText: 'Enter $label',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                errorText: errorText,
                errorStyle: const TextStyle(fontSize: 12),
              ),
              style: const TextStyle(fontSize: 16),
            ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B0000),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
