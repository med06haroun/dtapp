import 'package:flutter/material.dart';

class SelectNumberPage extends StatefulWidget {
  final String phoneNumber;
  final String operationType; // "forfait" ou "credit"
  final Function(String selectedNumber) onNumberSelected;

  const SelectNumberPage({
    super.key,
    required this.phoneNumber,
    required this.operationType,
    required this.onNumberSelected,
  });

  @override
  _SelectNumberPageState createState() => _SelectNumberPageState();
}

class _SelectNumberPageState extends State<SelectNumberPage> {
  bool _isForSelf = true;
  final TextEditingController _otherNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Définition des couleurs de Djibouti Telecom
    const Color djiboutiBlue = Color(0xFF002555);
    const Color djiboutiYellow = Color(0xFFF7C700);

    String title =
        widget.operationType == "forfait"
            ? "Achat de forfait"
            : "Acheter du crédit";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: djiboutiBlue,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choisir le destinataire",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Cartes de sélection pour "Mon numéro" et "Autre numéro"
              Row(
                children: [
                  // Carte "Mon numéro"
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isForSelf = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                _isForSelf
                                    ? djiboutiYellow
                                    : Colors.grey.shade300,
                            width: _isForSelf ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.phone_android,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: djiboutiYellow,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_upward,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Recharge",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Mon numéro",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Carte "Autre numéro"
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isForSelf = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                !_isForSelf
                                    ? djiboutiYellow
                                    : Colors.grey.shade300,
                            width: !_isForSelf ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.phone_android,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: djiboutiYellow,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_outward,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Recharge",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Autre numéro",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Champ pour saisir un autre numéro
              if (!_isForSelf) ...[
                const SizedBox(height: 24),
                TextFormField(
                  controller: _otherNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Numéro de téléphone",
                    hintText: "Ex: 77 12 34 56",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: djiboutiBlue,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un numéro de téléphone";
                    }
                    // Validation simple - peut être renforcée selon les formats de numéros à Djibouti
                    if (value.length < 8) {
                      return "Le numéro doit comporter au moins 8 chiffres";
                    }
                    return null;
                  },
                ),
              ],

              const Spacer(),

              // Bouton pour continuer
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_isForSelf ||
                        (_formKey.currentState?.validate() ?? false)) {
                      String selectedNumber =
                          _isForSelf
                              ? widget.phoneNumber
                              : _otherNumberController.text;
                      widget.onNumberSelected(selectedNumber);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: djiboutiBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Continuer",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
