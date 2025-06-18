import 'package:flutter/material.dart';

class BillPaymentConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> bill;
  final String paymentMethod;
  final Color djiboutiYellow;
  final Color djiboutiBlue;

  const BillPaymentConfirmationScreen({
    Key? key,
    required this.bill,
    required this.paymentMethod,
    required this.djiboutiYellow,
    required this.djiboutiBlue,
  }) : super(key: key);

  Widget _buildResponsiveInfoRow(
    String label,
    String value,
    bool isSmallScreen,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 14,
            color: Colors.grey[700],
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 12 : 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Générer un numéro de transaction unique
    final String transactionId =
        'PAIE-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
    final String currentDate =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    final String currentTime =
        '${DateTime.now().hour}:${DateTime.now().minute}';

    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: djiboutiBlue,
        automaticallyImplyLeading: false, // Empêcher le retour arrière standard
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de succès
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green[700],
                      size: isSmallScreen ? 30 : 40,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paiement réussi !',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Votre facture a été payée avec succès',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Détails du reçu
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Détails du reçu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: djiboutiBlue,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Payé',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 10 : 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  _buildResponsiveInfoRow(
                    'Facture:',
                    bill['invoiceNumber'],
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow('Type:', bill['type'], isSmallScreen),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Montant:',
                    bill['amount'],
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Méthode:',
                    paymentMethod == 'D-Money'
                        ? 'D-Money'
                        : 'Compte principal mobile',
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Date de paiement:',
                    '$currentDate à $currentTime',
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'N° Transaction:',
                    transactionId,
                    isSmallScreen,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Message d'information
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: djiboutiBlue,
                    size: isSmallScreen ? 18 : 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Votre facture a été payée avec succès. Vous pouvez consulter l\'historique de vos paiements dans la section "Historique".',
                      style: TextStyle(
                        color: djiboutiBlue,
                        fontSize: isSmallScreen ? 12 : 14,
                      ),
                    ),
                  ),
                ],
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
                child: TextButton.icon(
                  icon: Icon(
                    Icons.share_outlined,
                    size: isSmallScreen ? 16 : 18,
                    color: djiboutiBlue,
                  ),
                  label: Text(
                    'Partager',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: djiboutiBlue,
                    ),
                  ),
                  onPressed: () {
                    // Logique pour partager le reçu
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: djiboutiBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Retourner à la page Ma ligne
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text(
                    'Terminer',
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
}
