import 'package:flutter/material.dart';
import 'package:dtmobile/pages/package_purchase_page.dart';
import 'package:dtmobile/pages/credit_recharge_page.dart';
import 'package:dtmobile/pages/bill_payment_page.dart';
import 'package:dtmobile/pages/money_transfer_page.dart';

class HomePage extends StatelessWidget {
  final String phoneNumber;

  const HomePage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Définition des couleurs de Djibouti Telecom
    const Color djiboutiYellow = Color.fromARGB(255, 255, 228, 132);
    const Color djiboutiBlue = Color.fromARGB(255, 14, 80, 161);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(djiboutiBlue, djiboutiYellow),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section de bienvenue
              _buildWelcomeSection(djiboutiBlue),
              const SizedBox(height: 20),
              // Cartes des comptes
              Row(
                children: [
                  Expanded(
                    child: AccountCard(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Main Account',
                      balance: '4,500',
                      suffix: 'u',
                      primaryColor: djiboutiBlue,
                      accentColor: djiboutiYellow,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AccountCard(
                      icon: Icons.add_card,
                      label: 'Solde D-Money',
                      balance: '8,000',
                      suffix: 'DJF',
                      primaryColor: djiboutiBlue,
                      accentColor: djiboutiYellow,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Boutons d'actions rapides
              _buildQuickActions(context, djiboutiBlue, djiboutiYellow),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(djiboutiBlue),
    );
  }

  AppBar _buildAppBar(Color primaryColor, Color accentColor) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Dt-Mobile',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () {},
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '20',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.question_answer_outlined, color: Colors.white),
          onPressed: () {},
        ),
        const Icon(Icons.account_circle_sharp, size: 30, color: Colors.white),
      ],
    );
  }

  Widget _buildWelcomeSection(Color primaryColor) {
    return Text(
      'Bienvenue, $phoneNumber',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    Color primaryColor,
    Color accentColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          icon: Icons.local_mall_sharp,
          label: 'Achat de\nforfait',
          primaryColor: primaryColor,
          accentColor: accentColor,
          onTap: () => _navigateToPackagePurchase(context),
        ),
        _buildActionButton(
          icon: Icons.add_circle,
          label: 'Recharge de\ncrédit',
          primaryColor: primaryColor,
          accentColor: accentColor,
          onTap: () => _navigateToCreditRecharge(context),
        ),
        _buildActionButton(
          icon: Icons.receipt_long,
          label: 'Payer vos\nfactures',
          primaryColor: primaryColor,
          accentColor: accentColor,
          onTap: () => _navigateToBillPayment(context),
        ),
        _buildActionButton(
          icon: Icons.send,
          label: 'Transfert\nd\'argent',
          primaryColor: primaryColor,
          accentColor: accentColor,
          onTap: () => _navigateToMoneyTransfer(context),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(Color primaryColor) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
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

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color primaryColor,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 18,
              child: Icon(icon, color: accentColor, size: 18),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Méthodes de navigation
  void _navigateToPackagePurchase(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackagePurchasePage(phoneNumber: phoneNumber),
      ),
    );
  }

  void _navigateToCreditRecharge(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreditRechargePage(phoneNumber: phoneNumber),
      ),
    );
  }

  void _navigateToBillPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillPaymentPage(phoneNumber: phoneNumber),
      ),
    );
  }

  void _navigateToMoneyTransfer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoneyTransferPage(phoneNumber: phoneNumber),
      ),
    );
  }
}

class AccountCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String balance;
  final String suffix;
  final Color primaryColor;
  final Color accentColor;

  const AccountCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.balance,
    required this.suffix,
    required this.primaryColor,
    required this.accentColor,
  }) : super(key: key);

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool _showBalance = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(widget.icon, color: Colors.white, size: 20),
          const SizedBox(height: 8),
          Text(
            widget.label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                _showBalance ? widget.balance : '******',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_showBalance && widget.suffix.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(
                  widget.suffix,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showBalance = !_showBalance;
                  });
                },
                child: Icon(
                  _showBalance ? Icons.visibility : Icons.visibility_off,
                  color: widget.accentColor,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
