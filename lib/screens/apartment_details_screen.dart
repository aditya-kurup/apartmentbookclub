import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_theme.dart';

class ApartmentDetailsScreen extends StatefulWidget {
  const ApartmentDetailsScreen({super.key});

  @override
  State<ApartmentDetailsScreen> createState() => _ApartmentDetailsScreenState();
}

class _ApartmentDetailsScreenState extends State<ApartmentDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apartmentNumberController = TextEditingController();
  final _buildingController = TextEditingController();
  final _floorController = TextEditingController();
  bool _isLoading = false;
  String? _selectedApartmentType;
  bool _allowContactByNeighbors = true;
  bool _participateInBookClub = true;

  final List<String> _apartmentTypes = [
    'Studio',
    '1 Bedroom',
    '2 Bedroom',
    '3 Bedroom',
    'Penthouse'
  ];

  @override
  void dispose() {
    _apartmentNumberController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    super.dispose();
  }

  Future<void> _completeSetup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      // Navigate to home screen after successful setup
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Apartment Details',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Help us customize your experience',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildApartmentNumberField(),
                        const SizedBox(height: 16),
                        _buildBuildingField(),
                        const SizedBox(height: 16),
                        _buildFloorField(),
                        const SizedBox(height: 16),
                        _buildApartmentTypeDropdown(),
                        const SizedBox(height: 24),
                        _buildPreferencesSection(),
                        const SizedBox(height: 32),
                        _buildCompleteButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApartmentNumberField() {
    return TextFormField(
      controller: _apartmentNumberController,
      decoration: InputDecoration(
        labelText: 'Apartment Number',
        hintText: 'e.g., 4B, 301, A12',
        prefixIcon: const Icon(Icons.home_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your apartment number';
        }
        return null;
      },
    );
  }

  Widget _buildBuildingField() {
    return TextFormField(
      controller: _buildingController,
      decoration: InputDecoration(
        labelText: 'Building Name/Number',
        hintText: 'e.g., Building A, Tower 1',
        prefixIcon: const Icon(Icons.business_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your building information';
        }
        return null;
      },
    );
  }

  Widget _buildFloorField() {
    return TextFormField(
      controller: _floorController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Floor Number',
        hintText: 'e.g., 3, 15',
        prefixIcon: const Icon(Icons.layers_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your floor number';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid floor number';
        }
        return null;
      },
    );
  }

  Widget _buildApartmentTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedApartmentType,
      decoration: InputDecoration(
        labelText: 'Apartment Type',
        prefixIcon: const Icon(Icons.apartment_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor),
        ),
      ),
      items: _apartmentTypes.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedApartmentType = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select your apartment type';
        }
        return null;
      },
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Community Preferences',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildPreferenceSwitch(
            title: 'Allow neighbors to contact me',
            subtitle: 'Other residents can reach out for book exchanges',
            value: _allowContactByNeighbors,
            onChanged: (value) {
              setState(() {
                _allowContactByNeighbors = value;
              });
            },
          ),
          const SizedBox(height: 12),
          _buildPreferenceSwitch(
            title: 'Participate in book club events',
            subtitle: 'Receive notifications about community events',
            value: _participateInBookClub,
            onChanged: (value) {
              setState(() {
                _participateInBookClub = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primaryColor,
        ),
      ],
    );
  }

  Widget _buildCompleteButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _completeSetup,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text(
              'Complete Setup',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
