import 'package:dtmobile/pages/BillPaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:dtmobile/pages/home_page.dart';
import 'package:dtmobile/pages/history_page.dart';

// Nouvelles pages pour remplacer les boîtes de dialogue
class RechargeScreen extends StatefulWidget {
  final String phoneNumber;
  final String? fixedLineNumber;
  static const Color djiboutiYellow = Color(0xFFF7C700); // Jaune/doré du logo
  static const Color djiboutiBlue = Color(0xFF002555); // Bleu marine du logo

  const RechargeScreen({
    super.key,
    required this.phoneNumber,
    this.fixedLineNumber,
    required Color djiboutiYellow,
    required Color djiboutiBlue,
  });

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController _rechargeAmountController =
      TextEditingController();
  String _selectedPaymentMethod = 'D-Money';

  @override
  void dispose() {
    _rechargeAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Recharger votre compte',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: RechargeScreen.djiboutiBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:
              () => Navigator.popUntil(context, (route) => route.isFirst),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informations de ligne
              Container(
                padding: const EdgeInsets.all(16),
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
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: RechargeScreen.djiboutiBlue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.home_filled,
                        color: RechargeScreen.djiboutiBlue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ligne fixe',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: RechargeScreen.djiboutiBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.fixedLineNumber ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Montant à recharger
              const Text(
                'Montant à recharger (DJF)',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _rechargeAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: RechargeScreen.djiboutiBlue,
                      width: 2,
                    ),
                  ),
                  hintText: 'Ex: 1000',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: RechargeScreen.djiboutiBlue,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // Méthode de paiement
              const Text(
                'Méthode de paiement',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 12),

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
                            ? RechargeScreen.djiboutiBlue
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
                          child: const Center(
                            child: Icon(
                              Icons.payment,
                              color: RechargeScreen.djiboutiBlue,
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
                          const Icon(
                            Icons.check_circle,
                            color: RechargeScreen.djiboutiBlue,
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
                            ? RechargeScreen.djiboutiBlue
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
                          child: const Center(
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: RechargeScreen.djiboutiBlue,
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
                          const Icon(
                            Icons.check_circle,
                            color: RechargeScreen.djiboutiBlue,
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
                    backgroundColor: RechargeScreen.djiboutiYellow,
                    foregroundColor: RechargeScreen.djiboutiBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Validation simple
                    if (_rechargeAmountController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Veuillez saisir un montant à recharger',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Navigation vers la page de confirmation
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => RechargeConfirmationScreen(
                              amount: _rechargeAmountController.text.trim(),
                              paymentMethod: _selectedPaymentMethod,
                              djiboutiYellow: RechargeScreen.djiboutiYellow,
                              djiboutiBlue: RechargeScreen.djiboutiBlue,
                            ),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                  child: const Text(
                    'Confirmer',
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

class RechargeConfirmationScreen extends StatelessWidget {
  final String amount;
  final String paymentMethod;
  final Color djiboutiYellow;
  final Color djiboutiBlue;

  const RechargeConfirmationScreen({
    super.key,
    required this.amount,
    required this.paymentMethod,
    required this.djiboutiYellow,
    required this.djiboutiBlue,
  });

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
    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    // Générer date et heure actuelles
    final String currentDate =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    final String currentTime =
        '${DateTime.now().hour}:${DateTime.now().minute}';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: RechargeScreen.djiboutiBlue,
        automaticallyImplyLeading: false,
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
                          'Votre demande a été traitée avec succès',
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
                          color: RechargeScreen.djiboutiBlue,
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
                    'Montant:',
                    '$amount DJF',
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Méthode:',
                    paymentMethod == 'D-Money' ? 'D-Money' : 'Mon solde',
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Date:',
                    '$currentDate à $currentTime',
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
                    color: RechargeScreen.djiboutiBlue,
                    size: isSmallScreen ? 18 : 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      paymentMethod == 'D-Money'
                          ? 'Votre demande de rechargement a été envoyée. Veuillez suivre les instructions sur votre téléphone pour finaliser la transaction.'
                          : 'Votre compte fixe a été rechargé avec succès. Vous pouvez maintenant utiliser votre solde pour vos appels et services.',
                      style: TextStyle(
                        color: RechargeScreen.djiboutiBlue,
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
                    color: RechargeScreen.djiboutiBlue,
                  ),
                  label: Text(
                    'Partager',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: RechargeScreen.djiboutiBlue,
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
                    backgroundColor: RechargeScreen.djiboutiBlue,
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

// Nouvelle page pour les options de forfait
class PackageOptionsScreen extends StatelessWidget {
  final Color djiboutiYellow;
  final Color djiboutiBlue;

  const PackageOptionsScreen({
    super.key,
    required this.djiboutiYellow,
    required this.djiboutiBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Choisir un forfait',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: RechargeScreen.djiboutiBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // Remplacer le code actuel des options de forfait par celui-ci
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Option Forfait Internet
            Card(
              elevation: 2, // Réduire l'ombre
              color: Colors.grey[50], // Couleur de fond très légère
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BuyPackageScreen(
                            packageType: 'internet',
                            djiboutiYellow: djiboutiYellow,
                            djiboutiBlue: RechargeScreen.djiboutiBlue,
                          ),
                    ),
                  ).then((_) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // Icône dans un container carré bleu clair
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.wifi,
                            color: djiboutiBlue,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forfait Internet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: RechargeScreen.djiboutiBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Données pour votre navigation',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
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

            const SizedBox(height: 10),

            // Option Forfait Appels
            Card(
              elevation: 2, // Réduire l'ombre
              color: Colors.grey[50], // Couleur de fond très légère
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BuyPackageScreen(
                            packageType: 'voice',
                            djiboutiYellow: djiboutiYellow,
                            djiboutiBlue: RechargeScreen.djiboutiBlue,
                          ),
                    ),
                  ).then((_) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // Icône dans un container carré vert clair
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.call,
                            color: RechargeScreen.djiboutiBlue,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forfait Appels',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: RechargeScreen.djiboutiBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Minutes pour vos appels',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
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

            const SizedBox(height: 10),
            // Option Forfait Combo
            Card(
              elevation: 2, // Réduire l'ombre
              color: Colors.grey[50], // Couleur de fond très légère
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BuyPackageScreen(
                            packageType: 'Combo',
                            djiboutiYellow: djiboutiYellow,
                            djiboutiBlue: RechargeScreen.djiboutiBlue,
                          ),
                    ),
                  ).then((_) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // Icône dans un container carré bleu clair
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.widgets,
                            color: djiboutiBlue,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forfait Combo',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: RechargeScreen.djiboutiBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Données pour votre navigation et appels',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
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
    );
  }
}

// Nouvelle page pour acheter un forfait
class BuyPackageScreen extends StatefulWidget {
  final String packageType;
  final Color djiboutiYellow;
  final Color djiboutiBlue;

  const BuyPackageScreen({
    super.key,
    required this.packageType,
    required this.djiboutiYellow,
    required this.djiboutiBlue,
  });

  @override
  State<BuyPackageScreen> createState() => _BuyPackageScreenState();
}

class _BuyPackageScreenState extends State<BuyPackageScreen> {
  late Map<String, dynamic> selectedPackageDetails;
  late String selectedPackage;
  late List<Map<String, dynamic>> availablePackages;

  @override
  void initState() {
    super.initState();

    // Initialiser les forfaits disponibles selon le type
    availablePackages =
        widget.packageType == 'internet'
            ? [
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
            ]
            : [
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

    // Sélectionner le premier forfait par défaut
    selectedPackage = availablePackages[0]['name'];
    selectedPackageDetails = availablePackages[0];
  }

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
    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          widget.packageType == 'internet'
              ? 'Forfaits Internet'
              : 'Forfaits Appels',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: RechargeScreen.djiboutiBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...availablePackages.map(
              (package) => Card(
                elevation: 0.5,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color:
                        selectedPackage == package['name']
                            ? RechargeScreen.djiboutiBlue
                            : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedPackage = package['name'];
                      selectedPackageDetails = package;
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
                              widget.packageType == 'internet'
                                  ? Icons.wifi
                                  : Icons.call,
                              color: RechargeScreen.djiboutiBlue,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Texte avec détails
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${package['price']} DJF - ${package['validity']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (selectedPackage == package['name'])
                          const Icon(
                            Icons.check_circle,
                            color: RechargeScreen.djiboutiBlue,
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
            ),

            const SizedBox(height: 20),

            // Résumé du forfait
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Résumé du forfait',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: RechargeScreen.djiboutiBlue,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildResponsiveInfoRow(
                    'Forfait:',
                    selectedPackage,
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Prix:',
                    '${selectedPackageDetails['price']} DJF',
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Validité:',
                    selectedPackageDetails['validity'],
                    isSmallScreen,
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
                    backgroundColor: RechargeScreen.djiboutiYellow,
                    foregroundColor: RechargeScreen.djiboutiBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Naviguer vers la page de méthode de paiement
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PackagePaymentMethodScreen(
                              packageDetails: selectedPackageDetails,
                              djiboutiYellow: RechargeScreen.djiboutiYellow,
                              djiboutiBlue: RechargeScreen.djiboutiBlue,
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
            ],
          ),
        ),
      ),
    );
  }
}

// Nouvelle page pour la sélection du mode de paiement pour les forfaits
class PackagePaymentMethodScreen extends StatefulWidget {
  final Map<String, dynamic> packageDetails;
  final Color djiboutiYellow;
  final Color djiboutiBlue;

  const PackagePaymentMethodScreen({
    super.key,
    required this.packageDetails,
    required this.djiboutiYellow,
    required this.djiboutiBlue,
  });

  @override
  State<PackagePaymentMethodScreen> createState() =>
      _PackagePaymentMethodScreenState();
}

class _PackagePaymentMethodScreenState
    extends State<PackagePaymentMethodScreen> {
  String _selectedPaymentMethod = 'D-Money';

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
    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Méthode de paiement',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: RechargeScreen.djiboutiBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Résumé du forfait choisi
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
                    widget.packageDetails['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 14 : 16,
                      color: RechargeScreen.djiboutiBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Prix: ${widget.packageDetails['price']} DJF - Validité: ${widget.packageDetails['validity']}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.packageDetails['description'],
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11 : 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Choisissez comment payer:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: RechargeScreen.djiboutiBlue,
                fontSize: isSmallScreen ? 13 : 15,
              ),
            ),

            const SizedBox(height: 16),

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
                        child: const Center(
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: Color(0xFF002555), // djiboutiBlue
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

            const SizedBox(height: 12),

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
                          ? RechargeScreen.djiboutiBlue
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
                        child: const Center(
                          child: Icon(
                            Icons.payment,
                            color: Color(0xFF002555), // djiboutiBlue
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
                    'Retour',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RechargeScreen.djiboutiYellow,
                    foregroundColor: RechargeScreen.djiboutiBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Afficher un indicateur de chargement puis naviguer vers la confirmation
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
                  (context) => PurchaseConfirmationScreen(
                    packageDetails: widget.packageDetails,
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
                'Traitement en cours...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.djiboutiBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Veuillez patienter pendant que nous traitons votre demande.',
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

// Nouvelle page pour la confirmation finale d'achat de forfait
class PurchaseConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> packageDetails;
  final String paymentMethod;
  final Color djiboutiYellow;
  final Color djiboutiBlue;

  const PurchaseConfirmationScreen({
    super.key,
    required this.packageDetails,
    required this.paymentMethod,
    required this.djiboutiYellow,
    required this.djiboutiBlue,
  });

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
        'TR-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
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
        backgroundColor: RechargeScreen.djiboutiBlue,
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
                          'Votre forfait a été activé avec succès',
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
                          color: RechargeScreen.djiboutiBlue,
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
                    'Forfait:',
                    packageDetails['name'],
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Montant:',
                    '${packageDetails['price']} DJF',
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
                    'Date:',
                    '$currentDate à $currentTime',
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'N° Transaction:',
                    transactionId,
                    isSmallScreen,
                  ),
                  const SizedBox(height: 8),
                  _buildResponsiveInfoRow(
                    'Validité:',
                    packageDetails['validity'],
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
                    color: RechargeScreen.djiboutiBlue,
                    size: isSmallScreen ? 18 : 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Votre forfait est maintenant actif. Vous pouvez le consulter dans la section "Mes forfaits actifs".',
                      style: TextStyle(
                        color: RechargeScreen.djiboutiBlue,
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
                    color: RechargeScreen.djiboutiBlue,
                  ),
                  label: Text(
                    'Partager',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: RechargeScreen.djiboutiBlue,
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
                    backgroundColor: RechargeScreen.djiboutiBlue,
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

class MyLinePage extends StatefulWidget {
  final String phoneNumber;

  const MyLinePage({super.key, required this.phoneNumber});

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
  void initState() {
    super.initState();
  }

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
        backgroundColor: RechargeScreen.djiboutiBlue,
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
                  const SizedBox(height: 16),
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
              color: RechargeScreen.djiboutiBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.phone_android,
              size: 32,
              color: RechargeScreen.djiboutiBlue,
            ),
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
                    color: RechargeScreen.djiboutiBlue,
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
            icon: Icon(Icons.qr_code, color: RechargeScreen.djiboutiBlue),
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
                  color: RechargeScreen.djiboutiBlue,
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
                  prefixIcon: Icon(
                    Icons.phone,
                    color: RechargeScreen.djiboutiBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: RechargeScreen.djiboutiBlue,
                      width: 2,
                    ),
                  ),
                  hintText: 'Ex: 21XXXXXX',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RechargeScreen.djiboutiBlue,
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
                      Icon(
                        Icons.home_filled,
                        color: RechargeScreen.djiboutiBlue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Ligne fixe',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: RechargeScreen.djiboutiBlue,
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
                    'Cité Maka Al-Moukarama - Djibouti ville',
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
                      color: RechargeScreen.djiboutiBlue,
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
                          color: RechargeScreen.djiboutiBlue,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'DJF',
                        style: TextStyle(
                          fontSize: 16,
                          color: RechargeScreen.djiboutiBlue,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: djiboutiYellow,
                      foregroundColor: RechargeScreen.djiboutiBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Naviguer vers la page de rechargement au lieu d'ouvrir une boîte de dialogue
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => RechargeScreen(
                                phoneNumber: widget.phoneNumber,
                                fixedLineNumber: _fixedLineNumber,
                                djiboutiYellow: RechargeScreen.djiboutiYellow,
                                djiboutiBlue: RechargeScreen.djiboutiBlue,
                              ),
                        ),
                      );
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mes forfaits actifs - Ligne fixe',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: RechargeScreen.djiboutiBlue,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // Naviguer vers la page des options de forfaits au lieu d'ouvrir une boîte de dialogue
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PackageOptionsScreen(
                            djiboutiYellow: djiboutiYellow,
                            djiboutiBlue: RechargeScreen.djiboutiBlue,
                          ),
                    ),
                  );
                },
                icon: Icon(Icons.add_circle_outline, color: djiboutiYellow),
                label: Text('Ajouter', style: TextStyle(color: djiboutiYellow)),
              ),
            ],
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
              color: RechargeScreen.djiboutiBlue,
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
              color: RechargeScreen.djiboutiBlue,
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
              color: RechargeScreen.djiboutiBlue,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildConsumptionCard(),
        const SizedBox(height: 16),
        // Ajout de la section Factures
        _buildBillsSection(),
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
                  color: RechargeScreen.djiboutiBlue,
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
                  onPressed:
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  HistoryPage(phoneNumber: widget.phoneNumber),
                        ),
                      ),
                  style: TextButton.styleFrom(
                    foregroundColor: RechargeScreen.djiboutiBlue,
                  ),
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
                color: RechargeScreen.djiboutiBlue,
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

  // Nouvelle méthode : section des factures
  Widget _buildBillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Factures - Ligne fixe',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: RechargeScreen.djiboutiBlue,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // Afficher toutes les factures dans une nouvelle page
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: djiboutiYellow,
                  size: 16,
                ),
                label: Text(
                  'Voir tout',
                  style: TextStyle(color: djiboutiYellow),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildBillsList(),
      ],
    );
  }

  Widget _buildBillsList() {
    // Données d'exemple pour l'historique des factures (limitées à 2 pour l'affichage compact)
    final billsHistory = [
      {
        'type': 'Facture Internet',
        'amount': '3,500 DJF',
        'date': '20 Avr 2025',
        'dueDate': '30 Avr 2025',
        'status': 'Non payée',
        'isPaid': false,
        'invoiceNumber': 'FACT-82539-2025',
      },
      {
        'type': 'Facture Téléphone',
        'amount': '1,200 DJF',
        'date': '15 Avr 2025',
        'dueDate': '25 Avr 2025',
        'status': 'Payée',
        'isPaid': true,
        'invoiceNumber': 'FACT-79845-2025',
      },
    ];

    return billsHistory.isEmpty
        ? _buildEmptyState('Aucune facture disponible')
        : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: billsHistory.length,
          itemBuilder: (context, index) {
            final bill = billsHistory[index];
            final isPaid = bill['isPaid'] as bool;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
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
                          bill['type'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: RechargeScreen.djiboutiBlue,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isPaid ? Colors.green[100] : Colors.amber[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            bill['status'].toString(),
                            style: TextStyle(
                              color:
                                  isPaid
                                      ? Colors.green[800]
                                      : Colors.amber[800],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Ajout du numéro de facture
                    Text(
                      'N° ${bill['invoiceNumber']}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date d\'émission',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                bill['date'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date d\'échéance',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                bill['dueDate'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Montant', style: TextStyle(fontSize: 14)),
                        Text(
                          bill['amount'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: RechargeScreen.djiboutiBlue,
                          ),
                        ),
                      ],
                    ),
                    if (!isPaid) ...[
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: RechargeScreen.djiboutiYellow,
                            foregroundColor: RechargeScreen.djiboutiBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // Action pour payer la facture
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => BillPaymentScreen(
                                      bill: bill,
                                      djiboutiYellow: djiboutiYellow,
                                      djiboutiBlue: djiboutiBlue,
                                    ),
                              ),
                            );
                          },
                          child: const Text(
                            'Payer maintenant',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
  }

  //

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

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 2, // Indice 2 pour la page Ma ligne
      type: BottomNavigationBarType.fixed,
      selectedItemColor: RechargeScreen.djiboutiBlue,
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

class BillPaymentPage extends StatelessWidget {
  final Map<String, dynamic> bill;
  final String phoneNumber;

  const BillPaymentPage({
    super.key,
    required this.bill,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    String selectedPaymentMethod = 'D-Money';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payer la facture',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: RechargeScreen.djiboutiBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Détails de la facture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: RechargeScreen.djiboutiBlue,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Type', bill['type']),
            _buildInfoRow('Montant', bill['amount']),
            _buildInfoRow('Date', bill['date']),
            _buildInfoRow('Échéance', bill['dueDate']),
            const SizedBox(height: 24),
            Text(
              'Méthode de paiement',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: RechargeScreen.djiboutiBlue,
              ),
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              context,
              'D-Money',
              selectedPaymentMethod,
              () => selectedPaymentMethod = 'D-Money',
            ),
            _buildPaymentOption(
              context,
              'Mobile',
              selectedPaymentMethod,
              () => selectedPaymentMethod = 'Mobile',
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: RechargeScreen.djiboutiYellow,
              foregroundColor: RechargeScreen.djiboutiBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BillPaymentConfirmationPage(
                        bill: bill,
                        paymentMethod: selectedPaymentMethod,
                      ),
                ),
              );
            },
            child: const Text(
              'Confirmer le paiement',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String method,
    String selectedMethod,
    VoidCallback onSelect,
  ) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                selectedMethod == method
                    ? RechargeScreen.djiboutiYellow
                    : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              method == 'D-Money'
                  ? Icons.account_balance_wallet
                  : Icons.phone_android,
              color: RechargeScreen.djiboutiBlue,
            ),
            const SizedBox(width: 12),
            Text(
              method,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: RechargeScreen.djiboutiBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BillPaymentConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> bill;
  final String paymentMethod;

  const BillPaymentConfirmationPage({
    super.key,
    required this.bill,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: RechargeScreen.djiboutiBlue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              Text(
                'Paiement réussi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: RechargeScreen.djiboutiBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Votre paiement de ${bill['amount']} via $paymentMethod a été effectué avec succès.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: RechargeScreen.djiboutiYellow,
                  foregroundColor: RechargeScreen.djiboutiBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'Retour à l\'accueil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
