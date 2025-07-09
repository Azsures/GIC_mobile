// This class represents the data structure for a single client.
// Using a dedicated data class is better than passing around many individual variables.
class Client {
  final String name;
  final String phone;
  final String? cpfCnpj;
  final String? street;
  final String? number;
  final String? neighborhood;
  final String? state;
  final String? city;

  Client({
    required this.name,
    required this.phone,
    this.cpfCnpj,
    this.street,
    this.number,
    this.neighborhood,
    this.state,
    this.city,
  });

  // A method to easily print the client's data, useful for debugging.
  void printData() {
    print('--- Saving Client Data ---');
    print('Nome: $name');
    print('Telefone: $phone');
    print('CPF/CNPJ: ${cpfCnpj ?? 'N/A'}');
    print('Rua: ${street ?? 'N/A'}');
    print('Número: ${number ?? 'N/A'}');
    print('Bairro: ${neighborhood ?? 'N/A'}');
    print('Estado: ${state ?? 'N/A'}');
    print('Cidade: ${city ?? 'N/A'}');
  }
}

// This class contains the business logic for the registration process.
class RegisterClientModel {

  // In a real application, this method would save the client to a
  // database (like SQLite or Firebase) or send it to a server via an API call.
  // It returns a boolean to indicate if the operation was successful.
  Future<bool> saveClientData(Client client) async {
    // For now, we'll simulate a network/database call with a short delay.
    await Future.delayed(const Duration(seconds: 1));

    // The core logic is here: TODO.
    client.printData();

    // Let's assume the save operation is always successful for this example.
    return true;
  }
}
