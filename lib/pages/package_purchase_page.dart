import 'package:flutter/material.dart';

class PackagePurchasePage extends StatefulWidget {
  final String phoneNumber;

  const PackagePurchasePage({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  _PackagePurchasePageState createState() => _PackagePurchasePageState();
}

class _PackagePurchasePageState extends State<PackagePurchasePage> {
  String _selectedPackageType = "Internet";
  final List<String> _packageTypes = [
    "Internet",
    "Appels",
    "SMS",
    "International",
  ];

  @override
  Widget build(BuildContext context) {
    // Définition des couleurs de Djibouti Telecom
    const Color djiboutiYellow = Color.fromARGB(255, 255, 228, 132);
    const Color djiboutiBlue = Color.fromARGB(255, 14, 80, 161);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: djiboutiBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Achat de forfait',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: djiboutiBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choisissez votre forfait',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Numéro: ${widget.phoneNumber}',
                  style: TextStyle(color: djiboutiYellow, fontSize: 14),
                ),
              ],
            ),
          ),
          // Type de forfait
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Type de forfait',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _packageTypes.length,
                    itemBuilder: (context, index) {
                      final type = _packageTypes[index];
                      final isSelected = type == _selectedPackageType;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPackageType = type;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? djiboutiBlue : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? djiboutiBlue
                                      : Colors.grey.shade300,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            type,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Liste des forfaits
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  // Exemple de forfaits pour la démonstration
                  List<Map<String, dynamic>> internetPackages = [
                    {
                      'name': 'Forfait Journalier',
                      'data': '1 Go',
                      'validity': '24h',
                      'price': '500 DJF',
                      'description': 'Internet haut débit pour 24 heures',
                    },
                    {
                      'name': 'Forfait Hebdomadaire',
                      'data': '5 Go',
                      'validity': '7 jours',
                      'price': '1,500 DJF',
                      'description': 'Internet haut débit pour une semaine',
                    },
                    {
                      'name': 'Forfait Mensuel',
                      'data': '20 Go',
                      'validity': '30 jours',
                      'price': '5,000 DJF',
                      'description': 'Internet haut débit pour un mois',
                    },
                    {
                      'name': 'Forfait Premium',
                      'data': 'Illimité',
                      'validity': '30 jours',
                      'price': '8,000 DJF',
                      'description': 'Internet illimité pendant 30 jours',
                    },
                  ];

                  final package = internetPackages[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
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
                                package['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: djiboutiBlue,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: djiboutiYellow,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  package['price'],
                                  style: TextStyle(
                                    color: djiboutiBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: package['data'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: ' - Validité: ${package['validity']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            package['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Logique d'achat à implémenter
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text('Confirmation d\'achat'),
                                        content: Text(
                                          'Voulez-vous acheter le forfait ${package['name']} pour ${package['price']} ?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: Text('Annuler'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Achat effectué avec succès!',
                                                  ),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: djiboutiBlue,
                                            ),
                                            child: Text('Confirmer'),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: djiboutiBlue,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Acheter',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: djiboutiYellow
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
