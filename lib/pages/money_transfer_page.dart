import 'package:flutter/material.dart';

class MoneyTransferPage extends StatefulWidget {
  final String phoneNumber;

  const MoneyTransferPage({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  _MoneyTransferPageState createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
  String _selectedTransferType = "D-Money";
  final List<String> _transferTypes = ["D-Money", "Mobile à Mobile"];
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _recentContacts = [
    {'name': 'Ahmed Ali', 'number': '77123456', 'photo': null},
    {'name': 'Fatouma Omar', 'number': '77654321', 'photo': null},
    {'name': 'Hassan Youssouf', 'number': '77891234', 'photo': null},
  ];

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _messageController.dispose();
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
          'Transfert d\'argent',
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
                  'Transfert d\'argent',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Numéro: ${widget.phoneNumber}',
                      style: TextStyle(color: djiboutiYellow, fontSize: 14),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: djiboutiYellow,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            size: 16,
                            color: djiboutiBlue,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '8,000 DJF',
                            style: TextStyle(
                              color: djiboutiBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Type de transfert
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Type de transfert',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _transferTypes.length,
                    itemBuilder: (context, index) {
                      final type = _transferTypes[index];
                      final isSelected = type == _selectedTransferType;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTransferType = type;
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

          // Contacts récents
          if (_selectedTransferType == "D-Money" ||
              _selectedTransferType == "Mobile à Mobile") ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contacts récents',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _recentContacts.length,
                      itemBuilder: (context, index) {
                        final contact = _recentContacts[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _recipientController.text = contact['number'];
                            });
                          },
                          child: Container(
                            width: 70,
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: djiboutiBlue.withOpacity(
                                    0.2,
                                  ),
                                  child: Text(
                                    contact['name'][0],
                                    style: TextStyle(
                                      color: djiboutiBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  contact['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Formulaire de transfert
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            'Informations du transfert',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: djiboutiBlue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _recipientController,
                            decoration: InputDecoration(
                              hintText:
                                  _selectedTransferType == "International"
                                      ? '+2537XXXXXXX'
                                      : '77XXXXXX',
                              prefixIcon: Icon(
                                Icons.person,
                                color: djiboutiBlue,
                              ),
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
                          TextFormField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: 'Montant',
                              hintText: 'Entrez le montant',
                              suffixText: 'DJF',
                              prefixIcon: Icon(
                                Icons.attach_money,
                                color: djiboutiBlue,
                              ),
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
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Bouton de confirmation
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _validateAndSendTransfer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: djiboutiBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Confirmer le transfert',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validateAndSendTransfer() {
    final recipient = _recipientController.text.trim();
    final amount = _amountController.text.trim();
    final message = _messageController.text.trim();

    if (recipient.isEmpty) {
      _showErrorDialog('Veuillez entrer le numéro du destinataire');
      return;
    }

    if (amount.isEmpty) {
      _showErrorDialog('Veuillez entrer le montant du transfert');
      return;
    }

    final amountValue = double.tryParse(amount);
    if (amountValue == null || amountValue <= 0) {
      _showErrorDialog('Veuillez entrer un montant valide');
      return;
    }

    if (_selectedTransferType == "D-Money" && !recipient.startsWith('77')) {
      _showErrorDialog('Le numéro D-Money doit commencer par 77');
      return;
    }

    // Afficher la confirmation
    _showConfirmationDialog(recipient, amountValue, message);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showConfirmationDialog(
    String recipient,
    double amount,
    String message,
  ) {
    final transferFee = _calculateTransferFee(amount);
    final totalAmount = amount + transferFee;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Confirmer le transfert',
              style: TextStyle(color: Color.fromARGB(255, 14, 80, 161)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Destinataire: $recipient'),
                const SizedBox(height: 8),
                Text('Montant: ${amount.toStringAsFixed(0)} DJF'),
                const SizedBox(height: 8),
                Text('Frais: ${transferFee.toStringAsFixed(0)} DJF'),
                const SizedBox(height: 8),
                Text(
                  'Total: ${totalAmount.toStringAsFixed(0)} DJF',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (message.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text('Message: $message'),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 14, 80, 161),
                ),
                onPressed: () {
                  Navigator.pop(context); // Fermer la boîte de dialogue
                  _processTransfer(recipient, amount, message);
                },
                child: const Text(
                  'Confirmer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  double _calculateTransferFee(double amount) {
    switch (_selectedTransferType) {
      case "D-Money":
        return 0; // Pas de frais pour D-Money
      case "Mobile à Mobile":
        return amount * 0.01; // 1% de frais
      default:
        return 0;
    }
  }

  void _processTransfer(String recipient, double amount, String message) {
    // Simulation d'un transfert en cours
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Traitement du transfert...'),
              ],
            ),
          ),
    );

    // Simulation d'un délai de traitement
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Fermer l'indicateur de progression
      _showTransferSuccess(recipient, amount);
    });
  }

  void _showTransferSuccess(String recipient, double amount) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              'Transfert réussi',
              style: TextStyle(color: Colors.green),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Vous avez envoyé ${amount.toStringAsFixed(0)} DJF à $recipient',
                ),
                const SizedBox(height: 8),
                const Text('Le solde a été mis à jour.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Fermer la boîte de dialogue
                  Navigator.pop(context); // Retourner à la page précédente
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
