import 'package:flutter/material.dart';
import 'register_client_model.dart';

// Data class for a single order
class Order {
  final String orderId;
  final DateTime date;
  final double value;

  Order({required this.orderId, required this.date, required this.value});
}

class ClientDetailModel {
  // Simulates fetching a client's order history from a database.
  Future<List<Order>> getOrderHistory(String clientName) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, you would query a database using a client ID.
    // Here, we return mock data.
    return [
      Order(orderId: 'Carro', date: DateTime(2025, 6, 25), value: 70.00),
      Order(orderId: 'Moto', date: DateTime(2025, 5, 12), value: 39.90),
      Order(orderId: 'Carro', date: DateTime(2025, 3, 30), value: 70.00),
    ];
  }

  // Simulates updating client data in the database.
  Future<bool> updateClient(Client client) async {
    client.printData(); // Reusing the print method from the Client class
    await Future.delayed(const Duration(seconds: 1));
    return true; // Assume success
  }

  // Simulates deleting a client from the database.
  Future<bool> deleteClient(Client client) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // Assume success
  }
}
