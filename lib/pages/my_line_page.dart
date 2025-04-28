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

  // Variables pour le rechargement
  final TextEditingController _rechargeAmountController =
      TextEditingController();
  String _selectedPaymentMethod = 'D-Money';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fixedLineController.dispose();
    _rechargeAmountController.dispose();
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
                      // Ouvrir la boîte de dialogue de rechargement
                      _showRechargeDialog();
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

  void _showRechargeDialog() {
    // S'assurer que D-Money est sélectionné par défaut
    _selectedPaymentMethod = 'D-Money';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => Dialog(
                  backgroundColor:
                      Colors.grey[50], // Fond légèrement grisé pour le dialogue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: 400,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // En-tête
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Colors
                                    .grey[50], // Même couleur que le fond du dialogue
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            'Recharger votre compte',
                            style: TextStyle(
                              color: djiboutiBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        // Contenu
                        Flexible(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(
                              20.0,
                              10.0,
                              20.0,
                              20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Montant à recharger (DJF)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
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
                                      borderSide: BorderSide(
                                        color: Colors.grey[300]!,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey[300]!,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: djiboutiBlue,
                                        width: 2,
                                      ),
                                    ),
                                    hintText: 'Ex: 1000',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    prefixIcon: Icon(
                                      Icons.attach_money,
                                      color: djiboutiBlue,
                                    ),
                                    filled: true,
                                    fillColor:
                                        Colors
                                            .white, // Champ de texte avec fond blanc
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Méthode de paiement',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // D-Money option
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedPaymentMethod = 'D-Money';
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color:
                                            _selectedPaymentMethod == 'D-Money'
                                                ? djiboutiYellow
                                                : Colors.grey[200]!,
                                        width:
                                            _selectedPaymentMethod == 'D-Money'
                                                ? 2
                                                : 1,
                                      ),
                                      color:
                                          _selectedPaymentMethod == 'D-Money'
                                              ? Colors.blue[50]
                                              : Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.account_balance_wallet,
                                              color: djiboutiBlue,
                                              size: 26,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'D-Money',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Paiement via votre compte D-Money',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          _selectedPaymentMethod == 'D-Money'
                                              ? Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: djiboutiYellow,
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              )
                                              : Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.grey[400]!,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Mobile Account option
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedPaymentMethod = 'Mobile';
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color:
                                            _selectedPaymentMethod == 'Mobile'
                                                ? djiboutiYellow
                                                : Colors.grey[200]!,
                                        width:
                                            _selectedPaymentMethod == 'Mobile'
                                                ? 2
                                                : 1,
                                      ),
                                      color:
                                          _selectedPaymentMethod == 'Mobile'
                                              ? Colors.green[50]
                                              : Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.smartphone,
                                              color: Colors.green[700],
                                              size: 26,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Compte principal mobile',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Transfert depuis votre compte mobile',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          _selectedPaymentMethod == 'Mobile'
                                              ? Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: djiboutiYellow,
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              )
                                              : Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.grey[400]!,
                                                  ),
                                                  color: Colors.white,
                                                ),
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

                        // Boutons d'action
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            20.0,
                            0.0,
                            20.0,
                            20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey[700],
                                  backgroundColor: Colors.grey[200],
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'Annuler',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: djiboutiYellow,
                                  foregroundColor: djiboutiBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 14,
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  // Validation simple
                                  if (_rechargeAmountController.text
                                      .trim()
                                      .isEmpty) {
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

                                  // Logique pour traiter le paiement selon la méthode choisie
                                  Navigator.pop(context);
                                  _showRechargeConfirmationDialog();
                                },
                                child: const Text(
                                  'Confirmer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  void _showRechargeConfirmationDialog() {
    final amount = _rechargeAmountController.text.trim();

    if (amount.isEmpty) return;

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor:
                Colors
                    .grey[50], // Fond légèrement grisé pour le dialogue de confirmation
            child: Container(
              padding: const EdgeInsets.all(24.0),
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green[600],
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Demande envoyée',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: djiboutiBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _selectedPaymentMethod == 'D-Money'
                        ? 'Votre demande de rechargement de $amount DJF via D-Money a été envoyée. Veuillez suivre les instructions sur votre téléphone pour finaliser la transaction.'
                        : 'Votre demande de transfert de $amount DJF depuis votre compte principal mobile a été traitée avec succès. Le montant a été ajouté à votre solde fixe.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: djiboutiBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  // Nouvelle méthode améliorée avec responsivité : boîte de dialogue pour acheter des forfaits
  void _showBuyPackageDialog(String packageType) {
    // Liste des forfaits disponibles selon le type
    final List<Map<String, dynamic>> availablePackages =
        packageType == 'internet'
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

    String selectedPackage = availablePackages[0]['name'];
    Map<String, dynamic> selectedPackageDetails = availablePackages[0];

    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // Définir une largeur maximale pour éviter que la boîte de dialogue ne prenne toute la largeur
                  child: Container(
                    width: size.width > 600 ? 500 : null,
                    constraints: BoxConstraints(
                      maxHeight:
                          size.height *
                          0.8, // Limite la hauteur à 80% de l'écran
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            packageType == 'internet'
                                ? 'Forfaits Internet'
                                : 'Forfaits Appels',
                            style: TextStyle(
                              color: djiboutiBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 18 : 20,
                            ),
                          ),
                        ),
                        Divider(height: 1),
                        // Contenu scrollable
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...availablePackages.map(
                                    (package) => Card(
                                      elevation:
                                          selectedPackage == package['name']
                                              ? 3
                                              : 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color:
                                              selectedPackage == package['name']
                                                  ? djiboutiYellow
                                                  : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(bottom: 12),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedPackage = package['name'];
                                            selectedPackageDetails = package;
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: isSmallScreen ? 8 : 12,
                                          ),
                                          child: Row(
                                            children: [
                                              Radio<String>(
                                                value: package['name'],
                                                groupValue: selectedPackage,
                                                activeColor: djiboutiYellow,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedPackage = value!;
                                                    selectedPackageDetails =
                                                        package;
                                                  });
                                                },
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      package['name'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: djiboutiBlue,
                                                        fontSize:
                                                            isSmallScreen
                                                                ? 14
                                                                : 16,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          packageType ==
                                                                  'internet'
                                                              ? Icons.wifi
                                                              : Icons.call,
                                                          size:
                                                              isSmallScreen
                                                                  ? 14
                                                                  : 16,
                                                          color: djiboutiYellow,
                                                        ),
                                                        SizedBox(width: 4),
                                                        Expanded(
                                                          child: Text(
                                                            package['description'],
                                                            style: TextStyle(
                                                              fontSize:
                                                                  isSmallScreen
                                                                      ? 12
                                                                      : 14,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),
                                                    Wrap(
                                                      spacing: 8,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 8,
                                                                vertical: 2,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color:
                                                                Colors.blue[50],
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                          child: Text(
                                                            '${package['price']} DJF',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  djiboutiBlue,
                                                              fontSize:
                                                                  isSmallScreen
                                                                      ? 11
                                                                      : 13,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 8,
                                                                vertical: 2,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color:
                                                                Colors
                                                                    .green[50],
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                          child: Text(
                                                            'Validité: ${package['validity']}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors
                                                                      .green[700],
                                                              fontSize:
                                                                  isSmallScreen
                                                                      ? 11
                                                                      : 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 16),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(
                                      isSmallScreen ? 12 : 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Résumé du forfait',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: djiboutiBlue,
                                            fontSize: isSmallScreen ? 14 : 16,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        _buildResponsiveInfoRow(
                                          'Forfait:',
                                          selectedPackage,
                                          isSmallScreen,
                                        ),
                                        SizedBox(height: 4),
                                        _buildResponsiveInfoRow(
                                          'Prix:',
                                          '${selectedPackageDetails['price']} DJF',
                                          isSmallScreen,
                                        ),
                                        SizedBox(height: 4),
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
                          ),
                        ),
                        Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Annuler',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: isSmallScreen ? 13 : 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: djiboutiYellow,
                                  foregroundColor: djiboutiBlue,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 12 : 16,
                                    vertical: isSmallScreen ? 8 : 10,
                                  ),
                                ),
                                onPressed: () {
                                  // Continuer vers la sélection du mode de paiement
                                  Navigator.pop(context);
                                  _showPackagePaymentMethodDialog(
                                    selectedPackageDetails,
                                  );
                                },
                                child: Text(
                                  'Continuer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isSmallScreen ? 13 : 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  // Helper pour construire les lignes d'informations avec responsivité
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

  // Méthode de sélection du mode de paiement améliorée pour la responsivité
  void _showPackagePaymentMethodDialog(Map<String, dynamic> packageDetails) {
    String selectedPaymentMethod = 'D-Money';

    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: size.width > 600 ? 500 : null,
                    constraints: BoxConstraints(
                      maxHeight:
                          size.height *
                          0.7, // Limite la hauteur à 70% de l'écran
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Méthode de paiement',
                            style: TextStyle(
                              color: djiboutiBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 18 : 20,
                            ),
                          ),
                        ),
                        Divider(height: 1),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(
                                      isSmallScreen ? 12 : 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          packageDetails['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isSmallScreen ? 14 : 16,
                                            color: djiboutiBlue,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Prix: ${packageDetails['price']} DJF - Validité: ${packageDetails['validity']}',
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: isSmallScreen ? 12 : 14,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          packageDetails['description'],
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 11 : 13,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  Text(
                                    'Choisissez comment payer:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: djiboutiBlue,
                                      fontSize: isSmallScreen ? 13 : 15,
                                    ),
                                  ),
                                  SizedBox(height: 12),

                                  // Option D-Money - Plus responsive
                                  Card(
                                    elevation:
                                        selectedPaymentMethod == 'D-Money'
                                            ? 3
                                            : 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color:
                                            selectedPaymentMethod == 'D-Money'
                                                ? djiboutiYellow
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedPaymentMethod = 'D-Money';
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: isSmallScreen ? 8 : 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Radio<String>(
                                              value: 'D-Money',
                                              groupValue: selectedPaymentMethod,
                                              activeColor: djiboutiYellow,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPaymentMethod =
                                                      value!;
                                                });
                                              },
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                isSmallScreen ? 6 : 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[50],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.account_balance_wallet,
                                                color: djiboutiBlue,
                                                size: isSmallScreen ? 20 : 24,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'D-Money',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          isSmallScreen
                                                              ? 13
                                                              : 15,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Paiement via votre compte D-Money',
                                                    style: TextStyle(
                                                      fontSize:
                                                          isSmallScreen
                                                              ? 11
                                                              : 13,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  // Option Mobile Account - Plus responsive
                                  Card(
                                    elevation:
                                        selectedPaymentMethod == 'Mobile'
                                            ? 3
                                            : 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color:
                                            selectedPaymentMethod == 'Mobile'
                                                ? djiboutiYellow
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedPaymentMethod = 'Mobile';
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: isSmallScreen ? 8 : 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Radio<String>(
                                              value: 'Mobile',
                                              groupValue: selectedPaymentMethod,
                                              activeColor: djiboutiYellow,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPaymentMethod =
                                                      value!;
                                                });
                                              },
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                isSmallScreen ? 6 : 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green[50],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.smartphone,
                                                color: Colors.green[700],
                                                size: isSmallScreen ? 20 : 24,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Compte principal mobile',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          isSmallScreen
                                                              ? 13
                                                              : 15,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Transfert depuis votre compte mobile',
                                                    style: TextStyle(
                                                      fontSize:
                                                          isSmallScreen
                                                              ? 11
                                                              : 13,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                        ),
                        Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Retour',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: isSmallScreen ? 13 : 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: djiboutiYellow,
                                  foregroundColor: djiboutiBlue,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 12 : 16,
                                    vertical: isSmallScreen ? 8 : 10,
                                  ),
                                ),
                                onPressed: () {
                                  // Finaliser l'achat
                                  Navigator.pop(context);
                                  _showPackagePurchaseConfirmationDialog(
                                    packageDetails,
                                    selectedPaymentMethod,
                                  );
                                },
                                child: Text(
                                  'Payer maintenant',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isSmallScreen ? 13 : 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  // Méthode de confirmation d'achat améliorée pour la responsivité
  void _showFinalPurchaseConfirmation(
    Map<String, dynamic> packageDetails,
    String paymentMethod,
  ) {
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

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: size.width > 600 ? 500 : null,
              constraints: BoxConstraints(
                maxHeight:
                    size.height * 0.8, // Limite la hauteur à 80% de l'écran
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: isSmallScreen ? 30 : 40,
                          ),
                        ),
                        SizedBox(width: 15),
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
                              SizedBox(height: 4),
                              Text(
                                'Votre forfait a été activé avec succès',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
                                  Divider(height: 20),
                                  _buildResponsiveInfoRow(
                                    'Forfait:',
                                    packageDetails['name'],
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'Montant:',
                                    '${packageDetails['price']} DJF',
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'Méthode:',
                                    paymentMethod,
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'Date:',
                                    '$currentDate à $currentTime',
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'N° Transaction:',
                                    transactionId,
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'Validité:',
                                    packageDetails['validity'],
                                    isSmallScreen,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
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
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Votre forfait est maintenant actif. Vous pouvez le consulter dans la section "Mes forfaits actifs".',
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
                    ),
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: Icon(
                            Icons.share_outlined,
                            size: isSmallScreen ? 16 : 18,
                          ),
                          label: Text(
                            'Partager',
                            style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                          ),
                          onPressed: () {
                            // Logique pour partager le reçu
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: djiboutiBlue,
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: djiboutiBlue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                              vertical: isSmallScreen ? 8 : 10,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Terminer',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 13 : 14,
                            ),
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

  // Méthode mise à jour : confirmation d'achat de forfait avec animation
  void _showPackagePurchaseConfirmationDialog(
    Map<String, dynamic> packageDetails,
    String paymentMethod,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Pour simuler un traitement
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);

          // Afficher la confirmation finale
          _showFinalPurchaseConfirmation(packageDetails, paymentMethod);
        });

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              CircularProgressIndicator(color: djiboutiYellow, strokeWidth: 6),
              SizedBox(height: 24),
              Text(
                'Traitement en cours...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: djiboutiBlue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Veuillez patienter pendant que nous traitons votre demande.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Helper pour construire les lignes du reçu
  Widget _buildReceiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Nouvelle méthode : boîte de dialogue pour choisir le type de forfait
  void _showPackageOptionsDialog() {
    showDialog(
      context: context,
      builder:
          (context) => SimpleDialog(
            title: Text(
              'Choisir un type de forfait',
              style: TextStyle(
                color: djiboutiBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  _showBuyPackageDialog('internet');
                },
                child: ListTile(
                  leading: Icon(Icons.wifi, color: djiboutiYellow),
                  title: const Text('Forfait Internet'),
                  subtitle: const Text('Données pour votre navigation'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  _showBuyPackageDialog('voice');
                },
                child: ListTile(
                  leading: Icon(Icons.call, color: djiboutiYellow),
                  title: const Text('Forfait Appels'),
                  subtitle: const Text('Minutes pour vos appels'),
                ),
              ),
            ],
          ),
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
                  color: djiboutiBlue,
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
                            color: djiboutiBlue,
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
                            color: djiboutiBlue,
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
                            backgroundColor: djiboutiYellow,
                            foregroundColor: djiboutiBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // Action pour payer la facture
                            _showPaymentMethodDialog(bill);
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

  // Nouvelle méthode : boîte de dialogue de sélection de méthode de paiement
  // Nouvelle méthode corrigée pour le paiement des factures
  void _showPaymentMethodDialog(Map<String, dynamic> bill) {
    String selectedPaymentMethod = 'D-Money';

    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: size.width > 600 ? 500 : null,
                    constraints: BoxConstraints(
                      maxHeight:
                          size.height *
                          0.7, // Limite la hauteur à 70% de l'écran
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Payer la facture',
                            style: TextStyle(
                              color: djiboutiBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 18 : 20,
                            ),
                          ),
                        ),
                        Divider(height: 1),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Détails de la facture
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(
                                      isSmallScreen ? 12 : 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Facture: ${bill['invoiceNumber']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: isSmallScreen ? 13 : 15,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '${bill['amount']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isSmallScreen ? 20 : 24,
                                            color: djiboutiBlue,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Date d\'échéance: ${bill['dueDate']}',
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 12 : 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Type: ${bill['type']}',
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 12 : 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  Text(
                                    'Choisissez une méthode de paiement:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: djiboutiBlue,
                                      fontSize: isSmallScreen ? 14 : 15,
                                    ),
                                  ),
                                  SizedBox(height: 12),

                                  // Option D-Money
                                  Card(
                                    elevation:
                                        selectedPaymentMethod == 'D-Money'
                                            ? 3
                                            : 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color:
                                            selectedPaymentMethod == 'D-Money'
                                                ? djiboutiYellow
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedPaymentMethod = 'D-Money';
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: isSmallScreen ? 8 : 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Radio<String>(
                                              value: 'D-Money',
                                              groupValue: selectedPaymentMethod,
                                              activeColor: djiboutiYellow,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPaymentMethod =
                                                      value!;
                                                });
                                              },
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                isSmallScreen ? 6 : 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[50],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.account_balance_wallet,
                                                color: djiboutiBlue,
                                                size: isSmallScreen ? 20 : 24,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'D-Money',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          isSmallScreen
                                                              ? 13
                                                              : 15,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Paiement via votre compte D-Money',
                                                    style: TextStyle(
                                                      fontSize:
                                                          isSmallScreen
                                                              ? 11
                                                              : 13,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  // Option Mobile Account
                                  Card(
                                    elevation:
                                        selectedPaymentMethod == 'Mobile'
                                            ? 3
                                            : 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color:
                                            selectedPaymentMethod == 'Mobile'
                                                ? djiboutiYellow
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedPaymentMethod = 'Mobile';
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: isSmallScreen ? 8 : 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Radio<String>(
                                              value: 'Mobile',
                                              groupValue: selectedPaymentMethod,
                                              activeColor: djiboutiYellow,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPaymentMethod =
                                                      value!;
                                                });
                                              },
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                isSmallScreen ? 6 : 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green[50],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.smartphone,
                                                color: Colors.green[700],
                                                size: isSmallScreen ? 20 : 24,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Compte principal mobile',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          isSmallScreen
                                                              ? 13
                                                              : 15,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Paiement via le crédit de votre ligne mobile',
                                                    style: TextStyle(
                                                      fontSize:
                                                          isSmallScreen
                                                              ? 11
                                                              : 13,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                        ),
                        Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Annuler',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: isSmallScreen ? 13 : 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: djiboutiYellow,
                                  foregroundColor: djiboutiBlue,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 12 : 16,
                                    vertical: isSmallScreen ? 8 : 10,
                                  ),
                                ),
                                onPressed: () {
                                  // Finaliser le paiement
                                  Navigator.pop(context);
                                  _showBillPaymentLoadingDialog(
                                    bill,
                                    selectedPaymentMethod,
                                  );
                                },
                                child: Text(
                                  'Payer maintenant',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isSmallScreen ? 13 : 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  // Nouvelle méthode : affichage du chargement pour le paiement de facture
  void _showBillPaymentLoadingDialog(
    Map<String, dynamic> bill,
    String paymentMethod,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Pour simuler un traitement
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);

          // Afficher la confirmation finale
          _showBillPaymentConfirmationDialog(bill, paymentMethod);
        });

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              CircularProgressIndicator(color: djiboutiYellow, strokeWidth: 6),
              SizedBox(height: 24),
              Text(
                'Traitement du paiement...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: djiboutiBlue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Veuillez patienter pendant que nous traitons votre paiement.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Nouvelle méthode : confirmation du paiement de facture avec reçu
  void _showBillPaymentConfirmationDialog(
    Map<String, dynamic> bill,
    String paymentMethod,
  ) {
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

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: size.width > 600 ? 500 : null,
              constraints: BoxConstraints(
                maxHeight:
                    size.height * 0.8, // Limite la hauteur à 80% de l'écran
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: isSmallScreen ? 30 : 40,
                          ),
                        ),
                        SizedBox(width: 15),
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
                              SizedBox(height: 4),
                              Text(
                                'Votre facture a été payée avec succès',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
                                  Divider(height: 20),
                                  _buildResponsiveInfoRow(
                                    'Facture:',
                                    bill['invoiceNumber'],
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'Type:',
                                    bill['type'],
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'Montant:',
                                    bill['amount'],
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'Méthode:',
                                    paymentMethod == 'D-Money'
                                        ? 'D-Money'
                                        : 'Compte principal mobile',
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'Date de paiement:',
                                    '$currentDate à $currentTime',
                                    isSmallScreen,
                                  ),
                                  SizedBox(height: 8),
                                  _buildResponsiveInfoRow(
                                    'N° Transaction:',
                                    transactionId,
                                    isSmallScreen,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
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
                                  SizedBox(width: 10),
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
                    ),
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: Icon(
                            Icons.share_outlined,
                            size: isSmallScreen ? 16 : 18,
                          ),
                          label: Text(
                            'Partager',
                            style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                          ),
                          onPressed: () {
                            // Logique pour partager le reçu
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: djiboutiBlue,
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: djiboutiBlue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                              vertical: isSmallScreen ? 8 : 10,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Terminer',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 13 : 14,
                            ),
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

  // Nouvelle méthode : boîte de dialogue de confirmation de paiement
  void _showPaymentConfirmationDialog(
    Map<String, dynamic> bill,
    String paymentMethod,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 30),
                const SizedBox(width: 8),
                const Text('Paiement effectué'),
              ],
            ),
            content: Text(
              'Votre paiement de ${bill['amount']} via $paymentMethod pour la facture ${bill['invoiceNumber']} a été effectué avec succès.',
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: djiboutiBlue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
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
                  color: djiboutiBlue,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // Afficher les options de forfaits
                  _showPackageOptionsDialog();
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
