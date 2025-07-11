import 'package:flutter/material.dart';
import '../main.dart'; // Import to access the themeNotifier
import 'register_client_view.dart';
import 'consult_data_client_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A GlobalKey is used to programmatically open the Drawer.
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      // The AppBar at the top of the screen
      appBar: AppBar(
        // The leading widget is on the far left. We use an IconButton to open the drawer.
        leading: IconButton(
          icon: const Icon(Icons.menu), // The "3 parallel horizontal lines" icon
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
          tooltip: 'Abrir menu',
        ),
        title: const Text('GIC',style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        // 'actions' are the widgets on the right side of the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // Toggle the theme by changing the notifier's value
              themeNotifier.value = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
            tooltip: 'Mudar tema',
          ),
        ],
      ),
      // The side navigation menu
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Text(
                'Opções',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                // Handle navigation for settings
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () {
                // Handle navigation for about page
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      // The main content of the screen
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // GridView.count creates a 2D array of widgets
        child: GridView.count(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 16, // Horizontal space between cards
          mainAxisSpacing: 16, // Vertical space between cards
          children: <Widget>[
            // Reusable button widget for our menu
            _MenuButton(
              icon: Icons.person_add,
              label: 'Cadastrar',
              onTap: () {
                // Add this import at the top of home_screen.dart:
                // import 'register_client_screen.dart';

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterClientScreen()),
                );
              },
            ),
            _MenuButton(
              icon: Icons.people,
              label: 'Consultar dados',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientListScreen()),
                );
              },
            ),
            _MenuButton(
              icon: Icons.shopping_cart,
              label: 'Realizar Venda',
              onTap: () {
                // TODO: Navigate to Sales screen
              },
            ),
            _MenuButton(
              icon: Icons.assessment,
              label: 'Emitir Relatórios',
              onTap: () {
                // TODO: Navigate to Reports screen
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// A private reusable widget for the menu buttons to avoid code duplication.
class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color iconColor = isDarkMode ? Colors.cyan : Colors.blueAccent;

    return Card(
      // The Card widget provides the rounded border and shadow
      clipBehavior: Clip.antiAlias, // Ensures the InkWell ripple stays inside the rounded border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
