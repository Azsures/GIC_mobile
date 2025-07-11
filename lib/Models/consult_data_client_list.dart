import 'register_client_model.dart'; // We reuse the Client class from here

class ClientListModel {
  // In a real app, this would fetch data from a database or an API.
  // We use a Future to simulate the asynchronous nature of such operations.
  Future<List<Client>> getAllClients() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return a hardcoded list of clients for demonstration purposes.
    return [
      Client(name: 'Ana Silva', phone: '11987654321', city: 'São Paulo', state: 'SP'),
      Client(name: 'Bruno Costa', phone: '21912345678', city: 'Rio de Janeiro', state: 'RJ'),
      Client(name: 'Carlos Dias', phone: '31998761234', city: 'Belo Horizonte', state: 'MG'),
      Client(name: 'Daniela Souza', phone: '71987659876', city: 'Salvador', state: 'BA'),
      Client(name: 'Eduardo Lima', phone: '81912348765', city: 'Recife', state: 'PE'),
      Client(name: 'Fernanda Alves', phone: '41998765432', city: 'Curitiba', state: 'PR'),
    ];
  }
}
