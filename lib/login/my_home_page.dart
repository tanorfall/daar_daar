import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daar Daar Express'),
        backgroundColor: const Color.fromARGB(255, 215, 134, 48),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section de bienvenue
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

            // Boutons pour les services de livraison et de transport
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ServiceCard(
                  icon: Icons.delivery_dining,
                  title: 'Livraison',
                  color: Colors.blueAccent,
                  onTap: () {
                    // Action à définir plus tard
                    _showServiceMessage(context, 'Service de livraison');
                  },
                ),
                _ServiceCard(
                  icon: Icons.local_taxi,
                  title: 'Transport',
                  color: Colors.green,
                  onTap: () {
                    // Action à définir plus tard
                    _showServiceMessage(context, 'Service de transport');
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Section pour les commandes en cours
            Text(
              'Commandes en cours',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),

            // Liste des commandes fictives
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _OrderCard(
                  orderId: 'CMD001',
                  destination: 'Point E, Dakar',
                  status: 'En cours',
                ),
                _OrderCard(
                  orderId: 'CMD002',
                  destination: 'Mermoz, Dakar',
                  status: 'Livré',
                ),
                _OrderCard(
                  orderId: 'CMD003',
                  destination: 'Almadies, Dakar',
                  status: 'En attente',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour afficher un message temporaire pour chaque service
  void _showServiceMessage(BuildContext context, String service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$service sélectionné. Fonctionnalité à venir!')),
    );
  }
}

// Widget pour représenter chaque service comme une carte avec icône et titre
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
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// Widget pour afficher une commande en cours avec ses détails
class _OrderCard extends StatelessWidget {
  final String orderId;
  final String destination;
  final String status;

  const _OrderCard({
    required this.orderId,
    required this.destination,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          Icons.delivery_dining,
          color: status == 'Livré' ? Colors.green : Colors.orange,
        ),
        title: Text('Commande #$orderId'),
        subtitle: Text('Destination: $destination\nStatut: $status'),
      ),
    );
  }
}
