import 'package:flutter/material.dart';

class SelectNumberPage extends StatefulWidget {
  final String phoneNumber;
  final String operationType; // "forfait" ou "credit"
  final Function(String selectedNumber) onNumberSelected;

  const SelectNumberPage({
    Key? key,
    required this.phoneNumber,
    required this.operationType,
    required this.onNumberSelected,
  }) : super(key: key);

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
    const Color djiboutiYellow = Color(0xFFF7C700);
    const Color djiboutiBlue = Color(0xFF002555);

    String title =
        widget.operationType == "forfait"
            ? "Achat de forfait"
            : "Recharge de crédit";

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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pour qui souhaitez-vous ${widget.operationType == 'forfait' ? 'acheter ce forfait' : 'recharger du crédit'} ?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: djiboutiBlue,
                ),
              ),
              const SizedBox(height: 24),

              // Option pour soi-même
              RadioListTile<bool>(
                title: Text(
                  "Pour mon numéro (${widget.phoneNumber})",
                  style: const TextStyle(fontSize: 16),
                ),
                value: true,
                groupValue: _isForSelf,
                activeColor: djiboutiBlue,
                onChanged: (value) {
                  setState(() {
                    _isForSelf = value!;
                  });
                },
              ),

              // Option pour un autre numéro
              RadioListTile<bool>(
                title: const Text(
                  "Pour un autre numéro",
                  style: TextStyle(fontSize: 16),
                ),
                value: false,
                groupValue: _isForSelf,
                activeColor: djiboutiBlue,
                onChanged: (value) {
                  setState(() {
                    _isForSelf = value!;
                  });
                },
              ),

              // Champ pour saisir un autre numéro
              if (!_isForSelf) ...[
                const SizedBox(height: 16),
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
