import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _genderController = TextEditingController();
  final _civilStatusController = TextEditingController();
  final _birthdateController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'username': _usernameController.text,
        'password': _passwordController.text,
      });
    }
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool readOnly = false, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? 'Enter $label' : null,
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label,
      {bool confirm = false, bool obscure = true, VoidCallback? toggle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
            onPressed: toggle,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Enter $label';
          if (confirm && value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuesta Activity 2"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_fullnameController, "Full Name", Icons.person),
                _buildTextField(
                    _usernameController, "Username", Icons.account_circle),
                _buildPasswordField(
                  _passwordController,
                  "Password",
                  obscure: _obscurePassword,
                  toggle: () => setState(() {
                    _obscurePassword = !_obscurePassword;
                  }),
                ),
                _buildPasswordField(
                  _confirmPasswordController,
                  "Confirm Password",
                  confirm: true,
                  obscure: _obscureConfirmPassword,
                  toggle: () => setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  }),
                ),
                _buildTextField(_genderController, "Gender", Icons.male),
                _buildTextField(
                    _civilStatusController, "Civil Status", Icons.group),
                _buildTextField(
                  _birthdateController,
                  "Birthdate",
                  Icons.calendar_today,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
