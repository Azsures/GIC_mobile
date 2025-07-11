import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Controllers/detailed_client_informations.dart';
import '../Models/register_client_model.dart'; // For the Client class

class ClientDetailScreen extends StatefulWidget {
  final Client client;

  const ClientDetailScreen({super.key, required this.client});

  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  late final ClientDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ClientDetailController(widget.client);
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
        title: const Text('Detalhes do Cliente'),
      ),
      body: Column(
        children: [
          // The Expanded widget takes up all available space,
          // allowing the SingleChildScrollView to scroll within it.
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Dados Pessoais'),
                      _buildTextField(_controller.nameController, 'Nome'),
                      _buildTextField(_controller.phoneController, 'Telefone', keyboardType: TextInputType.number),
                      _buildTextField(_controller.cpfCnpjController, 'CPF/CNPJ', keyboardType: TextInputType.number),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Endereço'),
                      _buildTextField(_controller.streetController, 'Rua'),
                      _buildTextField(_controller.numberController, 'Número'),
                      _buildTextField(_controller.neighborhoodController, 'Bairro'),
                      _buildTextField(_controller.cityController, 'Cidade'),
                      _buildTextField(_controller.stateController, 'Estado'),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Histórico de Pedidos'),
                      _buildOrderHistoryTable(),
                    ],
                  ),
                );
              },
            ),
          ),
          // The action buttons are now the last child of the Column,
          // placing them at the bottom of the screen.
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildOrderHistoryTable() {
    if (_controller.isLoadingHistory) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_controller.orderHistory.isEmpty) {
      return const Center(child: Text('Nenhum pedido encontrado.'));
    }
    return Card(
      clipBehavior: Clip.antiAlias,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Pedido')),
          DataColumn(label: Text('Data')),
          DataColumn(label: Text('Valor'), numeric: true),
        ],
        rows: _controller.orderHistory.map((order) {
          return DataRow(cells: [
            DataCell(Text(order.orderId)),
            DataCell(Text(DateFormat('dd/MM/yyyy').format(order.date))),
            DataCell(Text('R\$ ${order.value.toStringAsFixed(2)}')),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: const Text('Excluir'),
                onPressed: () => _controller.deleteClient(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
                onPressed: () => _controller.saveChanges(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
