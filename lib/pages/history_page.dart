import 'package:flutter/material.dart';
import 'package:dtmobile/pages/home_page.dart';
import 'package:dtmobile/pages/my_line_page.dart';

class HistoryPage extends StatefulWidget {
  final String phoneNumber;

  const HistoryPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Définition des couleurs de Djibouti Telecom
  final Color djiboutiYellow = const Color(0xFFF7C700); // Jaune/doré du logo
  final Color djiboutiBlue = const Color(0xFF002555); // Bleu marine du logo

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: djiboutiBlue,
        title: const Text('Historique', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: djiboutiYellow,
          labelColor: djiboutiYellow,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Forfaits'),
            Tab(text: 'Transactions'),
            Tab(text: 'Factures'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPackageHistoryTab(),
          _buildTransactionsHistoryTab(),
          _buildBillsHistoryTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPackageHistoryTab() {
    // Données d'exemple pour l'historique des forfaits
    final packageHistory = [
      {
        'name': 'Forfait Internet 10 Go',
        'date': '23 Avr 2025',
        'price': '1,000 DJF',
        'status': 'Actif',
        'remaining': '4,2 Go',
      },
      {
        'name': 'Forfait Appels Illimités',
        'date': '15 Avr 2025',
        'price': '2,000 DJF',
        'status': 'Actif',
        'remaining': '45 min',
      },
      {
        'name': 'Forfait Internet 5 Go',
        'date': '10 Avr 2025',
        'price': '500 DJF',
        'status': 'Expiré',
        'remaining': '0 Go',
      },
      {
        'name': 'Forfait Mixte',
        'date': '01 Avr 2025',
        'price': '1,500 DJF',
        'status': 'Expiré',
        'remaining': '0 Go',
      },
    ];

    return packageHistory.isEmpty
        ? _buildEmptyState('Aucun historique de forfait disponible')
        : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: packageHistory.length,
          itemBuilder: (context, index) {
            final item = packageHistory[index];
            final isActive = item['status'] == 'Actif';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: djiboutiBlue,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isActive ? Colors.green[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['status']!,
                            style: TextStyle(
                              color:
                                  isActive
                                      ? Colors.green[800]
                                      : Colors.grey[700],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item['date']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item['price']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    if (isActive) ...[
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            item['name']!.contains('Internet')
                                ? Icons.data_usage
                                : Icons.access_time_filled,
                            color: djiboutiYellow,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Restant: ${item['remaining']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: djiboutiBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (item['name']!.contains('Internet'))
                        ClipRoundedRectangle(
                          child: LinearProgressIndicator(
                            value: 0.42, // Exemple: 4.2 Go sur 10 Go
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              djiboutiYellow,
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
  }

  Widget _buildTransactionsHistoryTab() {
    // Données d'exemple pour l'historique des transactions
    final transactionHistory = [
      {
        'type': 'Recharge',
        'amount': '+500 DJF',
        'date': '24 Avr 2025',
        'reference': 'REF123456789',
        'isIncoming': true,
      },
      {
        'type': 'Achat Forfait',
        'amount': '-1,000 DJF',
        'date': '23 Avr 2025',
        'reference': 'REF123456788',
        'isIncoming': false,
      },
      {
        'type': 'Transfert D-Money',
        'amount': '-2,000 DJF',
        'date': '20 Avr 2025',
        'reference': 'REF123456787',
        'isIncoming': false,
      },
      {
        'type': 'Recharge',
        'amount': '+1,000 DJF',
        'date': '15 Avr 2025',
        'reference': 'REF123456786',
        'isIncoming': true,
      },
    ];

    return transactionHistory.isEmpty
        ? _buildEmptyState('Aucune transaction disponible')
        : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: transactionHistory.length,
          itemBuilder: (context, index) {
            final transaction = transactionHistory[index];
            final isIncoming = transaction['isIncoming'] as bool;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isIncoming ? Colors.green[100] : Colors.red[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isIncoming ? Icons.add_circle : Icons.remove_circle,
                    color: isIncoming ? Colors.green[700] : Colors.red[700],
                  ),
                ),
                title: Text(
                  transaction['type'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      transaction['date'].toString(),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Réf: ${transaction['reference']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                trailing: Text(
                  transaction['amount'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isIncoming ? Colors.green[700] : Colors.red[700],
                  ),
                ),
              ),
            );
          },
        );
  }

  Widget _buildBillsHistoryTab() {
    // Données d'exemple pour l'historique des factures
    final billsHistory = [
      {
        'type': 'Facture Internet',
        'amount': '3,500 DJF',
        'date': '20 Avr 2025',
        'dueDate': '30 Avr 2025',
        'status': 'Non payée',
        'isPaid': false,
      },
      {
        'type': 'Facture Téléphone',
        'amount': '1,200 DJF',
        'date': '15 Avr 2025',
        'dueDate': '25 Avr 2025',
        'status': 'Payée',
        'isPaid': true,
      },
      {
        'type': 'Facture Internet',
        'amount': '3,500 DJF',
        'date': '20 Mar 2025',
        'dueDate': '30 Mar 2025',
        'status': 'Payée',
        'isPaid': true,
      },
      {
        'type': 'Facture Téléphone',
        'amount': '1,200 DJF',
        'date': '15 Mar 2025',
        'dueDate': '25 Mar 2025',
        'status': 'Payée',
        'isPaid': true,
      },
    ];

    return billsHistory.isEmpty
        ? _buildEmptyState('Aucune facture disponible')
        : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: billsHistory.length,
          itemBuilder: (context, index) {
            final bill = billsHistory[index];
            final isPaid = bill['isPaid'] as bool;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bill['type'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: djiboutiBlue,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isPaid ? Colors.green[100] : Colors.amber[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            bill['status'].toString(),
                            style: TextStyle(
                              color:
                                  isPaid
                                      ? Colors.green[800]
                                      : Colors.amber[800],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date d\'émission',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                bill['date'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date d\'échéance',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                bill['dueDate'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Montant', style: TextStyle(fontSize: 14)),
                        Text(
                          bill['amount'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: djiboutiBlue,
                          ),
                        ),
                      ],
                    ),
                    if (!isPaid) ...[
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: djiboutiYellow,
                            foregroundColor: djiboutiBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // Action pour payer la facture
                          },
                          child: const Text(
                            'Payer maintenant',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1, // Indice 1 pour la page Historique
      type: BottomNavigationBarType.fixed,
      selectedItemColor: djiboutiBlue,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index != 1) {
          // Si l'utilisateur n'appuie pas sur l'onglet actuel (Historique)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      index == 0
                          ? HomePage(phoneNumber: widget.phoneNumber)
                          : MyLinePage(phoneNumber: widget.phoneNumber),
            ),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Accueil'),
        BottomNavigationBarItem(
          icon: Icon(Icons.description_outlined),
          label: 'Historique',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'Ma ligne',
        ),
      ],
    );
  }
}

// Widget utilitaire pour les coins arrondis sur les LinearProgressIndicator
class ClipRoundedRectangle extends StatelessWidget {
  final Widget child;
  const ClipRoundedRectangle({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ClipRRect(borderRadius: BorderRadius.circular(8), child: child);
}
