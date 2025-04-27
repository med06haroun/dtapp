import 'package:flutter/material.dart';
import 'package:dtmobile/pages/select_number_page.dart';

class CreditRechargePage extends StatefulWidget {
  final String phoneNumber;

  const CreditRechargePage({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  _CreditRechargePageState createState() => _CreditRechargePageState();
}

class _CreditRechargePageState extends State<CreditRechargePage> {
  String? selectedNumber;
  String? selectedAmount;
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> amounts = ['500', '1000', '2000', '5000', '10000'];

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
              operationType: "credit",
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
          'Recharge de crédit',
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
                child: Form(
                  key: _formKey,
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
                            const Icon(
                              Icons.phone_android,
                              color: djiboutiBlue,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Numéro à recharger',
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

                      // Méthodes de recharge
                      Text(
                        'Méthode de recharge',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: djiboutiBlue,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Onglets pour les méthodes de recharge
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TabBar(
                                indicator: BoxDecoration(
                                  color: djiboutiBlue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.grey[600],
                                tabs: const [
                                  Tab(text: 'Carte de recharge'),
                                  Tab(text: 'D-Money'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height:
                                  300, // Hauteur fixe pour le contenu des onglets
                              child: TabBarView(
                                children: [
                                  // Onglet Carte de recharge
                                  _buildScratchCardTab(
                                    djiboutiBlue,
                                    djiboutiYellow,
                                  ),

                                  // Onglet D-Money
                                  _buildDMoneyTab(djiboutiBlue, djiboutiYellow),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildScratchCardTab(Color primaryColor, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Entrez le code à 14 chiffres présent sur votre carte de recharge',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _codeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Code de recharge',
            hintText: 'Ex: 12345678901234',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: const Icon(Icons.credit_card),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer le code de recharge';
            }
            if (value.length != 14) {
              return 'Le code doit comporter 14 chiffres';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Logique de validation du code de recharge
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Traitement de la recharge en cours...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Recharger',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDMoneyTab(Color primaryColor, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sélectionnez le montant à recharger',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),

        // Grille des montants
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              amounts.map((amount) {
                bool isSelected = amount == selectedAmount;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAmount = amount;
                    });
                  },
                  child: Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$amount DJF',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),

        const SizedBox(height: 24),
        Text(
          'Solde D-Money: 8,000 DJF',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                selectedAmount != null
                    ? () {
                      // Logique de recharge via D-Money
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Recharge de $selectedAmount DJF en cours...',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Recharger',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
