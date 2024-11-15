import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Daar Daar Express',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: const MyHomePage(title: 'Daar Daar Express'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const DashboardPage(),
    const CoursesPage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daar Daar Express'),
        backgroundColor: const Color.fromARGB(255, 215, 134, 48),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              themeNotifier.value =
                  themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Accueil'),
            activeColor: Colors.blueAccent,
          ),
          BottomBarItem(
            icon: const Icon(Icons.delivery_dining),
            title: const Text('Courses'),
            activeColor: Colors.green,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profil'),
            activeColor: Colors.orange,
          ),
          BottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            activeColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre principal
          Text(
            'Bienvenue sur Daar Daar Express',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Sélectionnez un service ci-dessous pour commencer',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          // Boutons pour Livraison et Transport
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _ServiceCard(
                  icon: Icons.delivery_dining,
                  title: 'Livraison',
                  color: Colors.blueAccent,
                  onTap: () {
                    _showServiceMessage(context, 'Service de livraison');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ServiceCard(
                  icon: Icons.local_taxi,
                  title: 'Transport',
                  color: Colors.green,
                  onTap: () {
                    _showServiceMessage(context, 'Service de transport');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Section des transactions récentes
          Text(
            'Transactions récentes',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),

          // Liste des transactions
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _TransactionCard(
                transactionId: 'TRX001',
                amount: '15,000 FCFA',
                date: '2024-11-01',
                status: 'Réussi',
              ),
              _TransactionCard(
                transactionId: 'TRX002',
                amount: '5,000 FCFA',
                date: '2024-11-03',
                status: 'Échoué',
              ),
              _TransactionCard(
                transactionId: 'TRX003',
                amount: '10,000 FCFA',
                date: '2024-11-10',
                status: 'En attente',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showServiceMessage(BuildContext context, String service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$service sélectionné. Fonctionnalité à venir!')),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final String transactionId;
  final String amount;
  final String date;
  final String status;

  const _TransactionCard({
    required this.transactionId,
    required this.amount,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          Icons.monetization_on,
          color: status == 'Réussi'
              ? Colors.green
              : (status == 'En attente' ? Colors.orange : Colors.red),
        ),
        title: Text('Transaction #$transactionId'),
        subtitle: Text('Montant: $amount\nDate: $date\nStatut: $status'),
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page des Courses'));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page de Profil'));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page des Paramètres'));
  }
}
