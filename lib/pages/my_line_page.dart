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
  String? _fixedLineNumber;
  final TextEditingController _fixedLineController = TextEditingController();
  bool _isFixedLineEntered = false;

  @override
  void dispose() {
    _fixedLineController.dispose();
    super.dispose();
  }

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
            // Affichage conditionnel basé sur la saisie du numéro fixe
            if (!_isFixedLineEntered)
              _buildFixedLineInputCard()
            else
              Column(
                children: [
                  _buildFixedLineInfoCard(),
                  const SizedBox(height: 16),
                  _buildBalanceCard(),
                  const SizedBox(height: 16),
                  _buildPackagesSection(),
                  const SizedBox(height: 16),
                  _buildServicesSection(),
                ],
              ),
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
                      'Mobile prépayé',
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

  Widget _buildFixedLineInputCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Consulter votre ligne fixe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: djiboutiBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Veuillez entrer votre numéro de ligne fixe pour consulter son statut et ses informations',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _fixedLineController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Numéro de ligne fixe',
                  prefixIcon: Icon(Icons.phone, color: djiboutiBlue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: djiboutiBlue, width: 2),
                  ),
                  hintText: 'Ex: 21XXXXXX',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: djiboutiBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Vérifier et traiter le numéro de ligne fixe
                    String inputNumber = _fixedLineController.text.trim();
                    if (inputNumber.isNotEmpty) {
                      setState(() {
                        _fixedLineNumber = inputNumber;
                        _isFixedLineEntered = true;
                      });
                    }
                  },
                  child: const Text(
                    'Consulter',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFixedLineInfoCard() {
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
                  Row(
                    children: [
                      Icon(Icons.home_filled, color: djiboutiBlue),
                      const SizedBox(width: 8),
                      Text(
                        'Ligne fixe',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: djiboutiBlue,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: djiboutiYellow),
                    onPressed: () {
                      setState(() {
                        _isFixedLineEntered = false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.phone, size: 18, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    _fixedLineNumber ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'Quartier 4 - Djibouti ville',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
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
                    'Solde principal - Ligne fixe',
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
                        _showBalance ? '6,200' : '****',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: djiboutiBlue,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'DJF',
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
                'Date d\'expiration: 15 Mai 2025',
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
            'Mes forfaits actifs - Ligne fixe',
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
                Icon(Icons.wifi, color: djiboutiYellow, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Internet Fixe',
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
                  percent: 0.65, // 65 Go sur 100 Go
                  center: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '65',
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
                  'Forfait Internet Fixe 100 Go',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Expire le 15 Mai 2025',
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
                  'Appels Fixe',
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
                  percent: 0.32, // 160 minutes sur 500 minutes
                  center: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '160',
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
                  'Forfait Appels Fixe 500 min',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Expire le 15 Mai 2025',
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
            'Consommation récente - Ligne fixe',
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
                'Internet fixe',
                '35 Go',
                '100 Go',
                0.35,
                Icons.wifi,
              ),
              const SizedBox(height: 16),
              // Appels
              _buildConsumptionItem(
                'Appels fixe',
                '340 min',
                '500 min',
                0.68,
                Icons.call,
              ),
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
