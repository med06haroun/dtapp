import 'package:flutter/material.dart';

class BillPaymentPage extends StatefulWidget {
  final String phoneNumber;

  const BillPaymentPage({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  _BillPaymentPageState createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  String _selectedBillType = "Internet";
  final List<String> _billTypes = ["Internet", "Téléphone fixe"];
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _billNumberController = TextEditingController();
  String _selectedPaymentMethod = "D-Money";
  final List<String> _paymentMethods = ["D-Money", "Main Account"];

  @override
  void dispose() {
    _customerIdController.dispose();
    _billNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Définition des couleurs de Djibouti Telecom
    const Color djiboutiYellow = Color(0xFFF7C700); // Jaune/doré du logo
    const Color djiboutiBlue = Color(0xFF002555); // Bleu marine du logo

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
          'Payer vos factures',
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
                  'Paiement de factures',
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

          // Type de facture
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Type de facture',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _billTypes.length,
                    itemBuilder: (context, index) {
                      final type = _billTypes[index];
                      final isSelected = type == _selectedBillType;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBillType = type;
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
                const SizedBox(height: 24),
                // Infos de la facture
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informations de la facture',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: djiboutiBlue,
                          ),
                        ),
                        const SizedBox(height: 16),

                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _billNumberController,
                          decoration: InputDecoration(
                            labelText: 'Numéro de facture',
                            hintText: 'Entrez le numéro de facture',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_billNumberController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Veuillez remplir tous les champs',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Simulation de la recherche de facture
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (context) => AlertDialog(
                                      content: Row(
                                        children: [
                                          CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  djiboutiBlue,
                                                ),
                                          ),
                                          const SizedBox(width: 16),
                                          Text('Recherche de la facture...'),
                                        ],
                                      ),
                                    ),
                              );

                              // Fermer la boîte de dialogue après 2 secondes
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.pop(context);
                                _showBillDetails();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: djiboutiBlue,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Rechercher la facture',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Pour toute assistance concernant le paiement de factures,\ncontactez-nous au 1515',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBillDetails() {
    // Définition des couleurs de Djibouti Telecom
    const Color djiboutiYellow = Color.fromARGB(255, 255, 228, 132);
    const Color djiboutiBlue = Color.fromARGB(255, 14, 80, 161);

    // Montant fictif pour la démonstration
    final int billAmount = 5000 + (DateTime.now().microsecond % 5000);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Détails de la facture',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: djiboutiBlue,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Type', _selectedBillType),
                _buildInfoRow('Numéro client', _customerIdController.text),
                _buildInfoRow('Numéro de facture', _billNumberController.text),
                _buildInfoRow('Période', 'Avril 2025'),
                _buildInfoRow('Date d\'échéance', '30/04/2025'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: djiboutiYellow.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Montant total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$billAmount DJF',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: djiboutiBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Méthode de paiement',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _paymentMethods.length,
                    itemBuilder: (context, index) {
                      final method = _paymentMethods[index];
                      final isSelected = method == _selectedPaymentMethod;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = method;
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
                          child: Row(
                            children: [
                              Icon(
                                method == "D-Money"
                                    ? Icons.account_balance_wallet
                                    : Icons.credit_card,
                                color: isSelected ? Colors.white : Colors.grey,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                method,
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Simulation du paiement
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder:
                            (context) => AlertDialog(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      djiboutiBlue,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text('Traitement du paiement...'),
                                ],
                              ),
                            ),
                      );

                      // Fermer la boîte de dialogue après 2 secondes
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                        // Afficher la confirmation
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 8),
                                    Text('Paiement réussi'),
                                  ],
                                ),
                                content: Text(
                                  'Votre facture de $billAmount DJF a été payée avec succès.',
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: djiboutiBlue,
                                    ),
                                    child: Text('Fermer'),
                                  ),
                                ],
                              ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: djiboutiBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Payer maintenant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
