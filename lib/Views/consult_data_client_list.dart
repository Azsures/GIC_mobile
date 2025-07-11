import 'package:flutter/material.dart';
import '../Controllers/consult_data_client_list.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  late final ClientListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ClientListController();
    _controller.init(); // Initialize controller and fetch data
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Clientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Search Bar ---
            TextField(
              controller: _controller.searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por nome',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // --- Client List ---
            Expanded(
              // AnimatedBuilder will rebuild its child whenever the controller calls notifyListeners()
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  if (_controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (_controller.filteredClients.isEmpty) {
                    return const Center(child: Text('Nenhum cliente encontrado.'));
                  }
                  // Using ListView.builder is efficient for long lists
                  return ListView.builder(
                    itemCount: _controller.filteredClients.length,
                    itemBuilder: (context, index) {
                      final client = _controller.filteredClients[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          title: Text(client.name),
                          subtitle: Text(client.phone),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _controller.navigateToClientDetails(context, client),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
