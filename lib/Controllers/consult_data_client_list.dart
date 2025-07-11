import 'package:flutter/material.dart';
import '../Models/consult_data_client_list.dart';
import '../Views/detailed_view_client.dart';
import '../Models/register_client_model.dart'; // For the Client class

class ClientListController with ChangeNotifier {
  final _model = ClientListModel();

  List<Client> _allClients = [];
  List<Client> filteredClients = [];
  bool isLoading = true;

  final searchController = TextEditingController();

  // This method is called when the screen is first created.
  void init() {
    // Listen for changes in the search bar
    searchController.addListener(_filterClients);

    // Fetch the initial data
    _model.getAllClients().then((clients) {
      _allClients = clients;
      filteredClients = clients;
      isLoading = false;
      notifyListeners(); // Notify the view to rebuild
    });
  }

  void _filterClients() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredClients = _allClients;
    } else {
      filteredClients = _allClients
          .where((client) => client.name.toLowerCase().contains(query))
          .toList();
    }
    notifyListeners(); // Notify the view that the filtered list has changed
  }

  void navigateToClientDetails(BuildContext context, Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientDetailScreen(client: client),
      ),
    );
  }

  @override
  void dispose() {
    searchController.removeListener(_filterClients);
    searchController.dispose();
    super.dispose();
  }
}
