import 'package:flutter/material.dart';
import 'package:dtmobile/pages/select_number_page.dart';

class CreditRechargePage extends StatefulWidget {
  final String phoneNumber;

  const CreditRechargePage({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  _CreditRechargePageState createState() => _CreditRechargePageState();
}

class _CreditRechargePageState extends State<CreditRechargePage>
    with SingleTickerProviderStateMixin {
  String? selectedNumber;
  String? selectedAmount;
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;

  final List<String> amounts = ['500', '1000', '2000', '5000', '10000'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Afficher d'abord la page de sélection du numéro
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSelectNumberPage();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          TextButton.icon(
            onPressed: _showSelectNumberPage,
            icon: const Icon(Icons.swap_horiz, color: djiboutiYellow),
            label: const Text(
              'Changer',
              style: TextStyle(color: djiboutiYellow),
            ),
          ),
        ],
      ),
      body:
          selectedNumber == null
              ? const Center(
                child: CircularProgressIndicator(color: djiboutiBlue),
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Affichage du numéro sélectionné avec un design plus moderne
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF0A2E5E), djiboutiBlue],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.phone_android,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Numéro à recharger',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  selectedNumber!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: _showSelectNumberPage,
                              icon: const Icon(
                                Icons.edit,
                                color: djiboutiYellow,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Titre Méthodes de recharge
                      const Row(
                        children: [
                          Icon(Icons.payments_outlined, color: djiboutiBlue),
                          SizedBox(width: 8),
                          Text(
                            'Méthode de recharge',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: djiboutiBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // TabBar redessiné
                      // Modifiez la partie du TabBar dans le build() comme ceci
                      Container(
                        height: 56,
                        child: TabBar(
                          controller: _tabController,
                          dividerHeight: 0,
                          indicator: BoxDecoration(
                            color: djiboutiBlue,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: djiboutiBlue.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          indicatorSize:
                              TabBarIndicatorSize.tab, // Ajoutez cette ligne
                          labelPadding: EdgeInsets.symmetric(
                            horizontal: 3,
                          ), // Ajustez si nécessaire
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey[700],
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13, // Réduit de 14 à 13
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13, // Réduit de 14 à 13
                          ),
                          tabs: const [
                            Tab(
                              child: FittedBox(
                                // Utilisation de FittedBox pour adapter le contenu
                                fit: BoxFit.cover,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.credit_card),
                                    SizedBox(width: 4), // Réduit de 8 à 4
                                    Text('Code de recharge'),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: FittedBox(
                                // Utilisation de FittedBox pour adapter le contenu
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.account_balance_wallet),
                                    SizedBox(width: 4), // Réduit de 8 à 4
                                    Text('D-Money'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // TabBarView avec contenu scrollable
                      SizedBox(
                        height: 380, // Hauteur augmentée pour éviter l'overflow
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Onglet Code de recharge redessiné
                            SingleChildScrollView(
                              child: _buildScratchCardTab(
                                djiboutiBlue,
                                djiboutiYellow,
                              ),
                            ),
                            // Onglet D-Money redessiné
                            SingleChildScrollView(
                              child: _buildDMoneyTab(
                                djiboutiBlue,
                                djiboutiYellow,
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Entrez le code à 12 chiffres de votre carte de recharge',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 16, letterSpacing: 1.2),
            decoration: InputDecoration(
              labelText: 'Code de recharge',
              hintText: 'Ex: 123456789012',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              prefixIcon: Icon(Icons.credit_card, color: primaryColor),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer le code de recharge';
              }
              if (value.length != 14) {
                return 'Le code doit comporter 12 chiffres';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 56,
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
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Recharger maintenant',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDMoneyTab(Color primaryColor, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: primaryColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              const Text('Solde D-Money: ', style: TextStyle(fontSize: 14)),
              Text(
                '8,000 DJF',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Sélectionnez le montant à recharger',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),

          // Grille des montants avec ajustement pour éviter l'overflow
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio:
                  1.8, // Augmenté pour rendre les cellules plus plates
              crossAxisSpacing: 8, // Réduit légèrement
              mainAxisSpacing: 8, // Réduit légèrement
            ),
            itemCount: amounts.length,
            itemBuilder: (context, index) {
              final amount = amounts[index];
              final isSelected = amount == selectedAmount;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAmount = amount;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                            : null,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          amount,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'DJF',
                          style: TextStyle(
                            color: isSelected ? Colors.white70 : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24), // Réduit légèrement (30 -> 24)
          SizedBox(
            width: double.infinity,
            height: 56,
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
                disabledBackgroundColor: Colors.grey.shade300,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Recharger avec D-Money',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    selectedAmount != null
                        ? Icons.arrow_forward
                        : Icons.lock_outline,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
