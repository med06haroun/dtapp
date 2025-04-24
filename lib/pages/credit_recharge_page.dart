import 'package:flutter/material.dart';

class CreditRechargePage extends StatefulWidget {
  final String phoneNumber;

  const CreditRechargePage({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  _CreditRechargePageState createState() => _CreditRechargePageState();
}

class _CreditRechargePageState extends State<CreditRechargePage> {
  String _selectedRechargeMethod = "Code de recharge";
  final List<String> _rechargeMethods = [
    "Code de recharge",
    "D-Money",
    "Carte bancaire",
  ];
  final TextEditingController _rechargeCodeController = TextEditingController();
  int _selectedAmount = 1000;
  final List<int> _predefinedAmounts = [500, 1000, 2000, 5000, 10000];

  @override
  void dispose() {
    _rechargeCodeController.dispose();
    super.dispose();
  }

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
          'Recharge de crédit',
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
                  'Rechargez votre crédit',
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

          // Méthode de recharge
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Méthode de recharge',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _rechargeMethods.length,
                    itemBuilder: (context, index) {
                      final method = _rechargeMethods[index];
                      final isSelected = method == _selectedRechargeMethod;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRechargeMethod = method;
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
                            method,
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

          // Contenu selon la méthode sélectionnée
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildRechargeMethodContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRechargeMethodContent() {
    switch (_selectedRechargeMethod) {
      case "Code de recharge":
        return _buildCodeRechargeContent();
      case "D-Money":
        return _buildDMoneyRechargeContent();
      case "Carte bancaire":
        return _buildCardRechargeContent();
      default:
        return Container();
    }
  }

  Widget _buildCodeRechargeContent() {
    const Color djiboutiBlue = Color.fromARGB(255, 14, 80, 161);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Entrez votre code de recharge',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _rechargeCodeController,
          decoration: InputDecoration(
            hintText: 'Ex: 1234567890',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          keyboardType: TextInputType.number,
          maxLength: 14,
        ),
        const SizedBox(height: 20),
        const Text(
          'Comment utiliser un code de recharge:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildInstructionStep(
          1,
          'Grattez la zone argentée de votre carte de recharge',
        ),
        _buildInstructionStep(2, 'Entrez le code à 14 chiffres ci-dessus'),
        _buildInstructionStep(3, 'Appuyez sur "Recharger" pour valider'),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_rechargeCodeController.text.length < 14) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Veuillez entrer un code de recharge valide'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Logique de validation du code
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text('Confirmation'),
                      content: Text(
                        'Confirmez-vous la recharge avec le code ${_rechargeCodeController.text} ?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Annuler'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Recharge effectuée avec succès!',
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
              padding: const EdgeInsets.symmetric(vertical: 16),
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
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDMoneyRechargeContent() {
    const Color djiboutiBlue = Color.fromARGB(255, 14, 80, 161);
    const Color djiboutiYellow = Color.fromARGB(255, 255, 228, 132);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sélectionnez un montant',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              _predefinedAmounts.map((amount) {
                final bool isSelected = amount == _selectedAmount;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAmount = amount;
                    });
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 48) / 3,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? djiboutiBlue : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? djiboutiBlue : Colors.grey.shade300,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${amount.toString()} DJF',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: djiboutiYellow.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: djiboutiBlue,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solde D-Money',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '8,000 DJF',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Logique de paiement avec D-Money
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text('Confirmation'),
                      content: Text(
                        'Confirmez-vous la recharge de $_selectedAmount DJF via D-Money ?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Annuler'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Recharge effectuée avec succès!',
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Recharger avec D-Money',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCardRechargeContent() {
    const Color djiboutiBlue = Color.fromARGB(255, 14, 80, 161);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sélectionnez un montant',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              _predefinedAmounts.map((amount) {
                final bool isSelected = amount == _selectedAmount;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAmount = amount;
                    });
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 48) / 3,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? djiboutiBlue : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? djiboutiBlue : Colors.grey.shade300,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${amount.toString()} DJF',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 24),
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
                  'Informations de paiement',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: djiboutiBlue,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Numéro de carte',
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date d\'expiration',
                          hintText: 'MM/AA',
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
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        maxLength: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Logique de paiement par carte
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text('Confirmation'),
                      content: Text(
                        'Confirmez-vous la recharge de $_selectedAmount DJF par carte bancaire ?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Annuler'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Recharge effectuée avec succès!',
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Payer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInstructionStep(int stepNumber, String instruction) {
    const Color djiboutiBlue = Color.fromARGB(255, 14, 80, 161);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: djiboutiBlue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
