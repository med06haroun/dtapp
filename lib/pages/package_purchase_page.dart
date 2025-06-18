import 'package:flutter/material.dart';
import 'package:dtmobile/pages/select_number_page.dart';

class PackagePurchasePage extends StatefulWidget {
  final String phoneNumber;

  const PackagePurchasePage({
    super.key,
    required this.phoneNumber,
    required packageDetails,
  });

  @override
  _PackagePurchasePageState createState() => _PackagePurchasePageState();
}

class _PackagePurchasePageState extends State<PackagePurchasePage> {
  String? selectedNumber;
  final PageController _pageController = PageController();
  int _currentStep = 0;
  String? selectedPackageType;
  PackageModel? selectedPackage;
  String? selectedPaymentMethod;

  // Couleurs Djibouti Telecom
  static const Color djiboutiYellow = Color(0xFFF7C700);
  static const Color djiboutiBlue = Color(0xFF002555);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSelectNumberPage();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                Navigator.pop(context);
              },
            ),
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedNumber == null) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: const Center(
          child: CircularProgressIndicator(color: djiboutiBlue),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildPackageTypePage(),
          _buildPackageSelectionPage(),
          _buildPaymentMethodPage(),
          _buildConfirmationPage(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    String title = '';
    switch (_currentStep) {
      case 0:
        title = 'Achat de forfait';
        break;
      case 1:
        title = selectedPackageType ?? 'Sélection forfait';
        break;
      case 2:
        title = 'Méthode de paiement';
        break;
      case 3:
        title = 'Confirmation';
        break;
    }

    return AppBar(
      backgroundColor: djiboutiBlue,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (_currentStep > 0) {
            _previousStep();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions:
          _currentStep < 2
              ? [
                TextButton(
                  onPressed: _showSelectNumberPage,
                  child: const Text(
                    'Changer',
                    style: TextStyle(
                      color: djiboutiYellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]
              : null,
    );
  }

  // Page 1: Sélection du type de forfait
  Widget _buildPackageTypePage() {
    return Column(
      children: [
        _buildSelectedNumberHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildPackageTypeCard(
                icon: Icons.wifi,
                title: 'Internet',
                onTap: () {
                  setState(() {
                    selectedPackageType = 'Internet';
                  });
                  _nextStep();
                },
              ),
              _buildPackageTypeCard(
                icon: Icons.widgets,
                title: 'Combo',
                onTap: () {
                  setState(() {
                    selectedPackageType = 'Combo';
                  });
                  _nextStep();
                },
              ),
              _buildPackageTypeCard(
                icon: Icons.flash_on,
                title: 'Tempo',
                onTap: () {
                  setState(() {
                    selectedPackageType = 'Tempo';
                  });
                  _nextStep();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 2: Sélection du forfait spécifique
  Widget _buildPackageSelectionPage() {
    return Column(
      children: [
        _buildSelectedNumberHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: _getPackagesForType(selectedPackageType ?? ''),
          ),
        ),
      ],
    );
  }

  // Page 3: Méthode de paiement
  Widget _buildPaymentMethodPage() {
    return Column(
      children: [
        _buildTransactionSummary(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildPaymentMethodCard(
                icon: Icons.account_balance_wallet,
                title: 'Mon solde',
                subtitle: '4500 U',
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = 'Mon solde';
                  });
                },
                isSelected: selectedPaymentMethod == 'Mon solde',
              ),
              _buildPaymentMethodCard(
                icon: Icons.payment,
                title: 'D-Money',
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = 'D-Money';
                  });
                },
                isSelected: selectedPaymentMethod == 'D-Money',
              ),
            ],
          ),
        ),
        _buildBottomButton(
          text: 'Confirmer',
          onPressed: selectedPaymentMethod != null ? _nextStep : null,
        ),
      ],
    );
  }

  // Page 4: Confirmation
  // Modification de la méthode _buildConfirmationPage() dans la classe _PackagePurchasePageState
  Widget _buildConfirmationPage() {
    // Générer un numéro de transaction unique
    final String currentDate =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    final String currentTime =
        '${DateTime.now().hour}:${DateTime.now().minute}';

    // Obtenir la taille de l'écran pour la responsivité
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return SingleChildScrollView(
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
                _buildInfoRow(
                  'Forfait:',
                  selectedPackage?.name ?? '',
                  isSmallScreen,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  'Montant:',
                  selectedPackage?.price ?? '',
                  isSmallScreen,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  'Méthode:',
                  selectedPaymentMethod == 'D-Money' ? 'D-Money' : 'Mon solde',
                  isSmallScreen,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  'Date:',
                  '$currentDate à $currentTime',
                  isSmallScreen,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  'Validité:',
                  selectedPackage?.validity ?? '',
                  isSmallScreen,
                ),
                if (selectedNumber != null) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow('Numéro:', selectedNumber!, isSmallScreen),
                ],
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

          const SizedBox(height: 32),

          // Boutons en bas
          Column(
            children: [
              _buildBottomButton(
                text: 'Acheter un autre Forfait',
                onPressed: () {
                  setState(() {
                    _currentStep = 0;
                    selectedPackageType = null;
                    selectedPackage = null;
                    selectedPaymentMethod = null;
                  });
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildBottomButton(
                text: 'Revenir à ma ligne',
                onPressed: () => Navigator.pop(context),
                isSecondary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Ajouter cette méthode helper pour les lignes d'informations
  Widget _buildInfoRow(String label, String value, bool isSmallScreen) {
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

  // Widgets communs
  Widget _buildSelectedNumberHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
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
                style: TextStyle(fontSize: 14, color: Colors.grey),
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
    );
  }

  Widget _buildTransactionSummary() {
    if (selectedPackage == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt, color: djiboutiBlue),
              const SizedBox(width: 8),
              Text(
                selectedPackage!.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            selectedPackage!.description,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const Divider(height: 24),
          const Text('Période', style: TextStyle(color: Colors.grey)),
          Text(
            selectedPackage!.validity,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: djiboutiYellow,
                ),
              ),
              Text(
                selectedPackage!.price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: djiboutiYellow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPackageTypeCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: djiboutiBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: djiboutiBlue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard({
    required PackageModel package,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: djiboutiBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      package.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (package.isPopular)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: djiboutiYellow,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'POPULAIRE',
                          style: TextStyle(
                            color: djiboutiBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.description,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    for (var detail in package.details)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Icon(detail.icon, size: 20, color: detail.color),
                            const SizedBox(width: 8),
                            Text(
                              '${detail.title}: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              detail.value,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 20,
                          color: djiboutiBlue,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Validité: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          package.validity,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          package.price,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: djiboutiBlue,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: djiboutiYellow,
                            foregroundColor: djiboutiBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'SÉLECTIONNER',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildPaymentMethodCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? djiboutiBlue : Colors.grey[200]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: djiboutiBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: djiboutiBlue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: djiboutiBlue)
                else
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton({
    required String text,
    required VoidCallback? onPressed,
    bool isSecondary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.white : djiboutiBlue,
          foregroundColor: isSecondary ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side:
                isSecondary
                    ? BorderSide(color: Colors.grey[300]!)
                    : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  List<Widget> _getPackagesForType(String type) {
    List<PackageModel> packages = [];

    switch (type) {
      case 'Internet':
        packages = [
          PackageModel(
            name: 'Express',
            description: '1 Go d\'internet mobile',
            price: '200 DJF',
            validity: '24h',
            details: [
              PackageDetailItem(
                icon: Icons.wifi,
                title: 'Data',
                value: '1 Go',
                color: djiboutiBlue,
              ),
            ],
          ),
          PackageModel(
            name: 'Découverte',
            description: '5 Go d\'internet mobile',
            price: '500 DJF',
            validity: '3 jours',
            details: [
              PackageDetailItem(
                icon: Icons.wifi,
                title: 'Data',
                value: '5 Go',
                color: djiboutiBlue,
              ),
            ],
          ),
          PackageModel(
            name: 'Évasion',
            description: '12 Go d\'internet mobile',
            price: '1,000 DJF',
            validity: '7 jours',
            isPopular: true,
            details: [
              PackageDetailItem(
                icon: Icons.wifi,
                title: 'Data',
                value: '12 Go',
                color: djiboutiBlue,
              ),
            ],
          ),
          PackageModel(
            name: 'Confort',
            description: '20 Go d\'internet mobile',
            price: '3,000 DJF',
            validity: '30 jours',
            isPopular: true,
            details: [
              PackageDetailItem(
                icon: Icons.wifi,
                title: 'Data',
                value: '20 Go',
                color: djiboutiBlue,
              ),
            ],
          ),
        ];
        break;

      case 'Combo':
        packages = [
          PackageModel(
            name: 'Classic',
            description: 'Forfait combiné données + appels + SMS',
            price: '500 DJF',
            validity: '30 jours',
            details: [
              PackageDetailItem(
                icon: Icons.wifi,
                title: 'Data',
                value: '100 Mo',
                color: djiboutiBlue,
              ),
              PackageDetailItem(
                icon: Icons.phone,
                title: 'Appels',
                value: '35 min',
                color: djiboutiBlue,
              ),
              PackageDetailItem(
                icon: Icons.message,
                title: 'SMS',
                value: '50 SMS',
                color: djiboutiBlue,
              ),
            ],
          ),

          PackageModel(
            name: 'Median',
            description: 'Forfait combiné données + appels + SMS',
            price: '1,000 DJF',
            validity: '30 jours',
            details: [
              PackageDetailItem(
                icon: Icons.wifi,
                title: 'Data',
                value: '200 Mo',
                color: djiboutiBlue,
              ),
              PackageDetailItem(
                icon: Icons.phone,
                title: 'Appels',
                value: '75 min',
                color: djiboutiBlue,
              ),
              PackageDetailItem(
                icon: Icons.message,
                title: 'SMS',
                value: '100 SMS',
                color: djiboutiBlue,
              ),
            ],
          ),

          PackageModel(
            name: 'Premium',
            description: 'Forfait combiné données + appels + SMS',
            price: '2,000 DJF',
            validity: '30 jours',
            details: [
              PackageDetailItem(
                icon: Icons.wifi,
                title: 'Data',
                value: '400 Mo',
                color: djiboutiBlue,
              ),
              PackageDetailItem(
                icon: Icons.phone,
                title: 'Appels',
                value: '155 min',
                color: djiboutiBlue,
              ),
              PackageDetailItem(
                icon: Icons.message,
                title: 'SMS',
                value: '250 SMS',
                color: djiboutiBlue,
              ),
            ],
          ),
        ];
        break;

      // Ajoutez d'autres types selon vos besoins
      default:
        packages = [
          PackageModel(
            name: 'Sensation',
            description: 'Forfait minutes d\'appel',
            price: '500 DJF',
            validity: '48h',
            details: [
              PackageDetailItem(
                icon: Icons.phone,
                title: 'Appels',
                value: '60 min',
                color: djiboutiBlue,
              ),
            ],
          ),
        ];
    }

    return packages
        .map(
          (package) => _buildPackageCard(
            package: package,
            onTap: () {
              setState(() {
                selectedPackage = package;
              });
              _nextStep();
            },
          ),
        )
        .toList();
  }
}

// Modèles de données
class PackageModel {
  final String name;
  final String description;
  final String price;
  final String validity;
  final List<PackageDetailItem> details;
  final bool isPopular;

  PackageModel({
    required this.name,
    required this.description,
    required this.price,
    required this.validity,
    required this.details,
    this.isPopular = false,
  });
}

class PackageDetailItem {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  PackageDetailItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });
}
