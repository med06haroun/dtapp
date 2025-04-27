import 'package:flutter/material.dart';
import 'package:dtmobile/pages/select_number_page.dart';

class PackagePurchasePage extends StatefulWidget {
  final String phoneNumber;

  const PackagePurchasePage({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  _PackagePurchasePageState createState() => _PackagePurchasePageState();
}

class _PackagePurchasePageState extends State<PackagePurchasePage> {
  String? selectedNumber;

  @override
  void initState() {
    super.initState();
    // Afficher d'abord la page de sélection du numéro
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSelectNumberPage();
    });
  }

  void _showSelectNumberPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SelectNumberPage(
              phoneNumber: widget.phoneNumber,
              operationType: "forfait",
              onNumberSelected: (number) {
                setState(() {
                  selectedNumber = number;
                });
                Navigator.pop(context); // Retourne à cette page après sélection
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Définition des couleurs de Djibouti Telecom
    const Color djiboutiYellow = Color(0xFFF7C700);
    const Color djiboutiBlue = Color(0xFF002555);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: djiboutiBlue,
        title: const Text(
          'Achat de forfait',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _showSelectNumberPage,
            child: Text(
              'Changer de numéro',
              style: TextStyle(color: djiboutiYellow),
            ),
          ),
        ],
      ),
      body:
          selectedNumber == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Affichage du numéro sélectionné
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.phone_android, color: djiboutiBlue),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Numéro sélectionné',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                selectedNumber!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Catégories de forfaits
                    Text(
                      'Catégories de forfaits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: djiboutiBlue,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Liste des catégories
                    _buildCategoryCard(
                      'Internet mobile',
                      'Forfaits data avec différents volumes',
                      Icons.wifi,
                      djiboutiBlue,
                      djiboutiYellow,
                    ),
                    const SizedBox(height: 12),
                    _buildCategoryCard(
                      'Appels & SMS',
                      'Minutes d\'appel et messages',
                      Icons.phone,
                      djiboutiBlue,
                      djiboutiYellow,
                    ),
                    const SizedBox(height: 12),
                    _buildCategoryCard(
                      'Forfaits combinés',
                      'Internet + Appels + SMS',
                      Icons.shopping_bag,
                      djiboutiBlue,
                      djiboutiYellow,
                    ),
                    const SizedBox(height: 12),
                    _buildCategoryCard(
                      'Offres internationales',
                      'Appels internationaux à tarifs réduits',
                      Icons.language,
                      djiboutiBlue,
                      djiboutiYellow,
                    ),

                    const SizedBox(height: 24),

                    // Forfaits recommandés
                    Text(
                      'Forfaits recommandés',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: djiboutiBlue,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Liste des forfaits recommandés
                    _buildPackageCard(
                      'Premium 10Go',
                      '10 Go + 60 min + 100 SMS',
                      '4,500 DJF',
                      '30 jours',
                      djiboutiBlue,
                      djiboutiYellow,
                    ),
                    const SizedBox(height: 12),
                    _buildPackageCard(
                      'Premium 20Go',
                      '20 Go + 120 min + 200 SMS',
                      '7,000 DJF',
                      '30 jours',
                      djiboutiBlue,
                      djiboutiYellow,
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    String description,
    IconData icon,
    Color primaryColor,
    Color accentColor,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: primaryColor,
          child: Icon(icon, color: accentColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigation vers les détails de la catégorie
        },
      ),
    );
  }

  Widget _buildPackageCard(
    String name,
    String description,
    String price,
    String validity,
    Color primaryColor,
    Color accentColor,
  ) {
    return Card(
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
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Populaire',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(validity, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logique d'achat du forfait
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Acheter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
