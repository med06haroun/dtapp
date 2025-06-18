import 'package:flutter/material.dart';

import 'package:dtmobile/pages/BillPaymentConfirmationScreen.dart';

class BillPaymentScreen extends StatefulWidget {
  final Map<String, dynamic> bill;
  final Color djiboutiYellow;
  final Color djiboutiBlue;

  const BillPaymentScreen({
    Key? key,
    required this.bill,
    required this.djiboutiYellow,
    required this.djiboutiBlue,
  }) : super(key: key);

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  String _selectedPaymentMethod = 'D-Money';

  @override
  Widget build(BuildContext context) {
    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Payer la facture',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: widget.djiboutiBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Détails de la facture
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Facture: ${widget.bill['invoiceNumber']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: isSmallScreen ? 13 : 15,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${widget.bill['amount']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 20 : 24,
                      color: widget.djiboutiBlue,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Date d\'échéance: ${widget.bill['dueDate']}',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Type: ${widget.bill['type']}',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            Text(
              'Choisissez une méthode de paiement:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: widget.djiboutiBlue,
                fontSize: isSmallScreen ? 14 : 15,
              ),
            ),

            SizedBox(height: 16),

            // Option D-Money
            Card(
              elevation: 0.5,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color:
                      _selectedPaymentMethod == 'D-Money'
                          ? widget.djiboutiBlue
                          : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 'D-Money';
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      // Icône dans un carré gris clair
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.payment,
                            color: widget.djiboutiBlue,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Texte simple
                      const Expanded(
                        child: Text(
                          'D-Money',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (_selectedPaymentMethod == 'D-Money')
                        Icon(
                          Icons.check_circle,
                          color: widget.djiboutiBlue,
                          size: 24,
                        )
                      else
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Option Mon solde
            Card(
              elevation: 0.5,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color:
                      _selectedPaymentMethod == 'Mobile'
                          ? widget.djiboutiBlue
                          : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 'Mobile';
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      // Icône dans un carré gris clair
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: widget.djiboutiBlue,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Texte avec sous-titre
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mon solde',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '4500 U',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedPaymentMethod == 'Mobile')
                        Icon(
                          Icons.check_circle,
                          color: widget.djiboutiBlue,
                          size: 24,
                        )
                      else
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    backgroundColor: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Annuler',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.djiboutiYellow,
                    foregroundColor: widget.djiboutiBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Montrer l'écran de chargement
                    _showLoadingThenNavigate(context);
                  },
                  child: const Text(
                    'Payer maintenant',
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

  // Méthode pour afficher l'écran de chargement puis naviguer
  void _showLoadingThenNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Pour simuler un traitement
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context); // Fermer le dialogue de chargement

          // Naviguer vers la page de confirmation finale
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BillPaymentConfirmationScreen(
                    bill: widget.bill,
                    paymentMethod: _selectedPaymentMethod,
                    djiboutiYellow: widget.djiboutiYellow,
                    djiboutiBlue: widget.djiboutiBlue,
                  ),
            ),
          );
        });

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              CircularProgressIndicator(
                color: widget.djiboutiYellow,
                strokeWidth: 6,
              ),
              const SizedBox(height: 24),
              Text(
                'Traitement du paiement...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.djiboutiBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Veuillez patienter pendant que nous traitons votre paiement.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
