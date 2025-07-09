import 'package:flutter/material.dart';
import '../Models/register_client_model.dart'; // Import the new model file

class RegisterClientController {
  // Form and text controllers remain the same
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  // The controller now has an instance of the model.
  final _model = RegisterClientModel();

  // This method contains the logic for when the save button is pressed.
  void saveClient(BuildContext context) async { // Make the method async
    if (formKey.currentState!.validate()) {
      // 1. Create a Client data object from the controllers' text.
      final client = Client(
        name: nameController.text,
        phone: phoneController.text,
        cpfCnpj: cpfCnpjController.text,
        street: streetController.text,
        number: numberController.text,
        neighborhood: neighborhoodController.text,
        state: stateController.text,
        city: cityController.text,
      );

      // 2. Delegate the saving logic to the model.
      final bool wasSaved = await _model.saveClientData(client);

      // 3. Handle the UI response based on the model's feedback.
      // This check is important to ensure we are still on the same screen.
      if (context.mounted) {
        if (wasSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cliente cadastrado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context); // Go back to the previous screen
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao salvar o cliente.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, corrija os erros no formulário.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Dispose method remains the same
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    cpfCnpjController.dispose();
    streetController.dispose();
    numberController.dispose();
    neighborhoodController.dispose();
    stateController.dispose();
    cityController.dispose();
  }
}
