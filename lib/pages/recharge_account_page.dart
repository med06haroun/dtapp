import 'package:flutter/material.dart';

class RechargeAccountPage extends StatefulWidget {
  final String phoneNumber;

  const RechargeAccountPage({super.key, required this.phoneNumber});

  @override
  _RechargeAccountPageState createState() => _RechargeAccountPageState();
}

class _RechargeAccountPageState extends State<RechargeAccountPage> {
  final Color djiboutiYellow = const Color(0xFFF7C700);
  final Color djiboutiBlue = const Color(0xFF002555);
  String _selectedPaymentMethod = 'D-Money';
  final TextEditingController _rechargeAmountController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recharger votre compte'),
        backgroundColor: djiboutiBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  ),
                  hintText: 'Ex: 1000',
                  prefixIcon: Icon(Icons.attach_money, color: djiboutiBlue),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Méthode de paiement',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 12),
              _buildPaymentMethodCard(
                'D-Money',
                Icons.account_balance_wallet,
                'Paiement via votre compte D-Money',
                Colors.blue[50]!,
                isSmallScreen,
              ),
              const SizedBox(height: 12),
              _buildPaymentMethodCard(
                'Mobile',
                Icons.smartphone,
                'Transfert depuis votre compte mobile',
                Colors.green[50]!,
                isSmallScreen,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: djiboutiYellow,
            foregroundColor: djiboutiBlue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => _processRecharge(context),
          child: const Text(
            'Confirmer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(
    String method,
    IconData icon,
    String description,
    Color bgColor,
    bool isSmallScreen,
  ) {
    return Card(
      elevation: _selectedPaymentMethod == method ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              _selectedPaymentMethod == method
                  ? djiboutiYellow
                  : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPaymentMethod = method;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Radio<String>(
                value: method,
                groupValue: _selectedPaymentMethod,
                activeColor: djiboutiYellow,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: method == 'D-Money' ? djiboutiBlue : Colors.green[700],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method == 'D-Money'
                          ? 'D-Money'
                          : 'Compte principal mobile',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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

  void _processRecharge(BuildContext context) {
    if (_rechargeAmountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez saisir un montant à recharger'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simuler le traitement
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              CircularProgressIndicator(color: djiboutiYellow),
              const SizedBox(height: 24),
              const Text(
                'Traitement en cours...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );

    // Simuler un délai de traitement
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Fermer le dialogue de chargement
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => RechargeConfirmationPage(
                amount: _rechargeAmountController.text,
                paymentMethod: _selectedPaymentMethod,
              ),
        ),
      );
    });
  }
}

class RechargeConfirmationPage extends StatelessWidget {
  final String amount;
  final String paymentMethod;
  final Color djiboutiYellow = const Color(0xFFF7C700);
  final Color djiboutiBlue = const Color(0xFF002555);

  const RechargeConfirmationPage({
    super.key,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final transactionId =
        'TR-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
    final currentDate =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    final currentTime = '${DateTime.now().hour}:${DateTime.now().minute}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
        backgroundColor: djiboutiBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green[600],
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Recharge réussie !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: djiboutiBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Votre compte a été rechargé avec succès',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
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
                      const Text('Montant rechargé'),
                      Text(
                        '$amount DJF',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text('Méthode'), Text(paymentMethod)],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Date'),
                      Text('$currentDate à $currentTime'),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('N° Transaction'),
                      Text(transactionId),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.share),
                label: const Text('Partager'),
                onPressed: () {
                  // Logique de partage
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: djiboutiBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: djiboutiBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Terminer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
