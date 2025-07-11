import 'package:flutter/material.dart';
import '../Models/detailed_client_informations.dart';
import '../Models/register_client_model.dart';

class ClientDetailController with ChangeNotifier {
  final Client _initialClient;
  final _model = ClientDetailModel();

  // Text editing controllers for each field
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController cpfCnpjController;
  late final TextEditingController streetController;
  late final TextEditingController numberController;
  late final TextEditingController neighborhoodController;
  late final TextEditingController stateController;
  late final TextEditingController cityController;

  List<Order> orderHistory = [];
  bool isLoadingHistory = true;

  ClientDetailController(this._initialClient) {
    // Initialize controllers with the client's data
    nameController = TextEditingController(text: _initialClient.name);
    phoneController = TextEditingController(text: _initialClient.phone);
    cpfCnpjController = TextEditingController(text: _initialClient.cpfCnpj);
    streetController = TextEditingController(text: _initialClient.street);
    numberController = TextEditingController(text: _initialClient.number);
    neighborhoodController = TextEditingController(text: _initialClient.neighborhood);
    stateController = TextEditingController(text: _initialClient.state);
    cityController = TextEditingController(text: _initialClient.city);

    // Fetch order history
    _model.getOrderHistory(_initialClient.name).then((history) {
      orderHistory = history;
      isLoadingHistory = false;
      notifyListeners();
    });
  }

  Future<void> saveChanges(BuildContext context) async {
    final updatedClient = Client(
      name: nameController.text,
      phone: phoneController.text,
      cpfCnpj: cpfCnpjController.text,
      street: streetController.text,
      number: numberController.text,
      neighborhood: neighborhoodController.text,
      state: stateController.text,
      city: cityController.text,
    );

    final success = await _model.updateClient(updatedClient);
    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente atualizado com sucesso!'), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao atualizar cliente.'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> deleteClient(BuildContext context) async {
    final success = await _model.deleteClient(_initialClient);
    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente excluído com sucesso!'), backgroundColor: Colors.orange),
      );
      // Pop twice to go back to the client list screen
      int popCount = 0;
      Navigator.popUntil(context, (route) => popCount++ == 2);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir cliente.'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    cpfCnpjController.dispose();
    streetController.dispose();
    numberController.dispose();
    neighborhoodController.dispose();
    stateController.dispose();
    cityController.dispose();
    super.dispose();
  }
}
