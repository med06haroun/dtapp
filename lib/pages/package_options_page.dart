import 'package:dtmobile/pages/package_purchase_page.dart';
import 'package:flutter/material.dart';

class PackageOptionsPage extends StatelessWidget {
  final Color djiboutiYellow = const Color(0xFFF7C700);
  final Color djiboutiBlue = const Color(0xFF002555);

  const PackageOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir un forfait'),
        backgroundColor: djiboutiBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPackageOption(
              context,
              'Forfait Internet',
              'Données pour votre navigation',
              Icons.wifi,
              Colors.blue[50]!,
              () => _navigateToPackageDetails(context, 'internet'),
            ),
            const SizedBox(height: 16),
            _buildPackageOption(
              context,
              'Forfait Appels',
              'Minutes pour vos appels',
              Icons.call,
              Colors.green[50]!,
              () => _navigateToPackageDetails(context, 'voice'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageOption(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color bgColor,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: djiboutiBlue, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: djiboutiBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: djiboutiYellow, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPackageDetails(BuildContext context, String packageType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PackageDetailsPage(
              packageType: packageType,
              onPackageSelected: (packageDetails) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PackagePurchasePage(
                          packageDetails: packageDetails,
                          phoneNumber: '',
                        ),
                  ),
                );
              },
            ),
      ),
    );
  }
}

class PackageDetailsPage extends StatefulWidget {
  final String packageType;

  const PackageDetailsPage({
    super.key,
    required this.packageType,
    required Null Function(dynamic packageDetails) onPackageSelected,
  });

  @override
  _PackageDetailsPageState createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  final Color djiboutiYellow = const Color(0xFFF7C700);
  final Color djiboutiBlue = const Color(0xFF002555);
  String? selectedPackage;

  List<Map<String, dynamic>> getPackages() {
    if (widget.packageType == 'internet') {
      return [
        {
          'name': 'Forfait Internet 5 Go',
          'price': '500',
          'validity': '7 jours',
          'description': 'Idéal pour une utilisation modérée',
        },
        {
          'name': 'Forfait Internet 10 Go',
          'price': '1000',
          'validity': '30 jours',
          'description': 'Pour vos besoins quotidiens',
        },
        {
          'name': 'Forfait Internet 20 Go',
          'price': '1800',
          'validity': '30 jours',
          'description': 'Utilisation intensive, streaming inclus',
        },
        {
          'name': 'Forfait Internet Illimité',
          'price': '3000',
          'validity': '30 jours',
          'description': 'Navigation illimitée pour tout usage',
        },
      ];
    } else {
      return [
        {
          'name': 'Forfait Appels 100 min',
          'price': '500',
          'validity': '15 jours',
          'description': 'Pour les appels occasionnels',
        },
        {
          'name': 'Forfait Appels 250 min',
          'price': '1200',
          'validity': '30 jours',
          'description': 'Pour vos appels réguliers',
        },
        {
          'name': 'Forfait Appels 500 min',
          'price': '2000',
          'validity': '30 jours',
          'description': 'Solution économique pour utilisation intense',
        },
        {
          'name': 'Forfait Appels Illimités',
          'price': '2500',
          'validity': '30 jours',
          'description': 'Liberté totale pour vos appels',
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final packages = getPackages();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.packageType == 'internet'
              ? 'Forfaits Internet'
              : 'Forfaits Appels',
        ),
        backgroundColor: djiboutiBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final package = packages[index];
          final isSelected = selectedPackage == package['name'];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? djiboutiYellow : Colors.transparent,
                width: 2,
              ),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedPackage = package['name'];
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: package['name'],
                          groupValue: selectedPackage,
                          activeColor: djiboutiYellow,
                          onChanged: (value) {
                            setState(() {
                              selectedPackage = value;
                            });
                          },
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: djiboutiBlue,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                package['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${package['price']} DJF',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: djiboutiBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Validité: ${package['validity']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: djiboutiYellow,
            foregroundColor: djiboutiBlue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed:
              selectedPackage == null
                  ? null
                  : () {
                    final selectedPackageDetails = packages.firstWhere(
                      (p) => p['name'] == selectedPackage,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PackagePurchasePage(
                              packageDetails: selectedPackageDetails,
                              phoneNumber: '',
                            ),
                      ),
                    );
                  },
          child: const Text(
            'Continuer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
