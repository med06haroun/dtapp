import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:dtmobile/pages/home_page.dart';
import 'package:dtmobile/pages/history_page.dart';

class MyLinePage extends StatefulWidget {
  final String phoneNumber;

  const MyLinePage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _MyLinePageState createState() => _MyLinePageState();
}

class _MyLinePageState extends State<MyLinePage> {
  // Définition des couleurs de Djibouti Telecom
  final Color djiboutiYellow = const Color(0xFFF7C700); // Jaune/doré du logo
  final Color djiboutiBlue = const Color(0xFF002555); // Bleu marine du logo

  bool _showBalance = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Ma ligne', style: TextStyle(color: Colors.white)),
        backgroundColor: djiboutiBlue,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {
              // Action pour les paramètres de la ligne
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneInfoHeader(),
            const SizedBox(height: 16),
            _buildBalanceCard(),
            const SizedBox(height: 16),
            _buildPackagesSection(),
            const SizedBox(height: 16),
            _buildServicesSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPhoneInfoHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: djiboutiBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.phone_android, size: 32, color: djiboutiBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.phoneNumber,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: djiboutiBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 12,
                            color: Colors.green[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Ligne active',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Fixe prépayé',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.qr_code, color: djiboutiBlue),
            onPressed: () {
              // Action pour afficher le QR code
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Solde principal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: djiboutiBlue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showBalance = !_showBalance;
                      });
                    },
                    child: Icon(
                      _showBalance ? Icons.visibility : Icons.visibility_off,
                      color: djiboutiYellow,
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        _showBalance ? '4,500' : '****',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: djiboutiBlue,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'u',
                        style: TextStyle(fontSize: 16, color: djiboutiBlue),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: djiboutiYellow,
                      foregroundColor: djiboutiBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Action pour recharger
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Recharger',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Date d\'expiration: 30 Mai 2025',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Mes forfaits actifs',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: djiboutiBlue,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildDataPackageCard(),
              const SizedBox(width: 12),
              _buildVoicePackageCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataPackageCard() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: djiboutiBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.data_usage, color: djiboutiYellow, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Internet',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 10.0,
                  percent: 0.42, // 4.2 Go sur 10 Go
                  center: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '4.2',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text('Go', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  progressColor: djiboutiYellow,
                  backgroundColor: Colors.grey[200]!,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Forfait Internet 10 Go',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Expire le 30 Avr 2025',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoicePackageCard() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: djiboutiBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.call, color: djiboutiYellow, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Appels',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 10.0,
                  percent: 0.15, // 45 minutes sur 300 minutes
                  center: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '45',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text('min', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  progressColor: djiboutiYellow,
                  backgroundColor: Colors.grey[200]!,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Forfait Appels 300 min',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Expire le 25 Avr 2025',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Services actifs',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: djiboutiBlue,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _buildServiceCard(
              'Appel en attente',
              'Service activé',
              Icons.call_merge,
              true,
            ),
            const SizedBox(height: 8),
            _buildServiceCard(
              'Transfert d\'appel',
              'Service désactivé',
              Icons.call_split,
              false,
            ),
            const SizedBox(height: 8),
            _buildServiceCard(
              'Roaming international',
              'Service activé',
              Icons.language,
              true,
            ),
            const SizedBox(height: 8),
            _buildServiceCard(
              'SMS international',
              'Service activé',
              Icons.message,
              true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Consommation récente',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: djiboutiBlue,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildConsumptionCard(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildServiceCard(
    String title,
    String status,
    IconData icon,
    bool isActive,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? djiboutiBlue.withOpacity(0.1) : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: isActive ? djiboutiBlue : Colors.grey[600]),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
          status,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.green[700] : Colors.grey[600],
          ),
        ),
        trailing: Switch(
          value: isActive,
          activeColor: djiboutiYellow,
          activeTrackColor: djiboutiBlue,
          onChanged: (value) {
            // Action pour activer/désactiver le service
            setState(() {
              // Code pour mettre à jour l'état du service
            });
          },
        ),
      ),
    );
  }

  Widget _buildConsumptionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Derniers 30 jours',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: djiboutiBlue,
                ),
              ),
              const SizedBox(height: 16),
              // Données
              _buildConsumptionItem(
                'Données mobiles',
                '5.8 Go',
                '10.0 Go',
                0.58,
                Icons.data_usage,
              ),
              const SizedBox(height: 16),
              // Appels
              _buildConsumptionItem(
                'Appels',
                '255 min',
                '300 min',
                0.85,
                Icons.call,
              ),
              const SizedBox(height: 16),
              // SMS
              _buildConsumptionItem('SMS', '28', '100', 0.28, Icons.message),
              const SizedBox(height: 16),
              // Bouton pour plus de détails
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                HistoryPage(phoneNumber: widget.phoneNumber),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(foregroundColor: djiboutiBlue),
                  child: const Text(
                    'Voir l\'historique détaillé',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConsumptionItem(
    String title,
    String used,
    String total,
    double percentage,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 14)),
            const Spacer(),
            Text(
              '$used / $total',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: djiboutiBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearPercentIndicator(
          lineHeight: 8.0,
          percent: percentage,
          progressColor: djiboutiYellow,
          backgroundColor: Colors.grey[200],
          barRadius: const Radius.circular(8),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 2, // Indice 2 pour la page Ma ligne
      type: BottomNavigationBarType.fixed,
      selectedItemColor: djiboutiBlue,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index != 2) {
          // Si l'utilisateur n'appuie pas sur l'onglet actuel (Ma ligne)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      index == 0
                          ? HomePage(phoneNumber: widget.phoneNumber)
                          : HistoryPage(phoneNumber: widget.phoneNumber),
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
