import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Controllers/register_client_controller.dart'; // Import the new controller

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({super.key});

  @override
  State<RegisterClientScreen> createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  // The View now holds an instance of the Controller.
  late final RegisterClientController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller when the state is created.
    _controller = RegisterClientController();
  }

  @override
  void dispose() {
    // Dispose of the controller's resources when the widget is removed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.cyan : Colors.blueAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Cliente'),
      ),
      // The Form widget now gets its key from the controller.
      body: SafeArea(
        child: Form(
          key: _controller.formKey,
          child: SingleChildScrollView( // Makes the form scrollable
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // --- Personal Data Section ---
                const Text('Dados Pessoais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  // Each TextFormField gets its controller from the _controller instance.
                  controller: _controller.nameController,
                  decoration: const InputDecoration(labelText: 'Nome *', border: OutlineInputBorder()),
                  maxLength: 150,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O nome é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controller.phoneController,
                  decoration: const InputDecoration(labelText: 'Telefone *', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 11,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O telefone é obrigatório.';
                    }
                    if (value.length < 10) {
                      return 'O telefone deve ter pelo menos 10 dígitos.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controller.cpfCnpjController,
                  decoration: const InputDecoration(labelText: 'CPF ou CNPJ', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 14,
                ),
                const SizedBox(height: 32),

                // --- Address Section ---
                const Text('Endereço', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controller.streetController,
                  decoration: const InputDecoration(labelText: 'Rua', border: OutlineInputBorder()),
                  maxLength: 150,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controller.numberController,
                  decoration: const InputDecoration(labelText: 'Número', border: OutlineInputBorder()),
                  maxLength: 12,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controller.neighborhoodController,
                  decoration: const InputDecoration(labelText: 'Bairro', border: OutlineInputBorder()),
                  maxLength: 100,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _controller.stateController,
                        decoration: const InputDecoration(labelText: 'Estado', border: OutlineInputBorder()),
                        maxLength: 2,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _controller.cityController,
                        decoration: const InputDecoration(labelText: 'Cidade', border: OutlineInputBorder()),
                        maxLength: 100,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // --- Save Button ---
                ElevatedButton(
                  // The onPressed callback now calls the controller's method.
                  onPressed: () => _controller.saveClient(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Salvar', style: TextStyle(fontSize: 16, color: textColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
