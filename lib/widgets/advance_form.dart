import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  DateTime? birthDate;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),
    );

    if (date != null) {
      setState(() {
        birthDate = date;
      });
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form valid'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Form'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    !value.contains('@')) {
                  return 'Email tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Minimal 6 karakter';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: selectDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                birthDate == null
                    ? 'Pilih tanggal lahir'
                    : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: submit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}