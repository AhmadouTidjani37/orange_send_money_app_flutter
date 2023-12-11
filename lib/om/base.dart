import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class OMTransfert extends StatefulWidget {
  const OMTransfert({super.key});

  @override
  State<OMTransfert> createState() => _OMTransfertState();
}

class _OMTransfertState extends State<OMTransfert> {
  TextEditingController destinataireController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController codeConfirmationController = TextEditingController();
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ 
               Colors.red.shade300,
               Colors.deepOrangeAccent,
              ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: Image.asset("assets/images/R.png",
          height: 100,),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                     colors: [
                      Colors.red,
               Colors.deepOrangeAccent,
      
                     ],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){
              _showPopupMenu(context);
            }, icon: Icon(Icons.more_vert,size: 30,),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Column(
            children: [
              Image.asset("assets/images/head.png",height: 150,),
              SizedBox(height: 20,),
              TextFormField(
                controller: destinataireController,
                decoration: InputDecoration(labelText: 'Destinataire'),
              ),
              TextFormField(
                controller: montantController,
                decoration: InputDecoration(labelText: 'Montant'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: codeConfirmationController,
                decoration: InputDecoration(labelText: 'Code de confirmation'),
              ),
              SizedBox(height:30),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                gradient:LinearGradient(
                colors: [
               Colors.red,
               Colors.deepOrangeAccent,
              ],
            ),
                ),
                child: InkWell(
                  onTap: (){
                    envoyerArgent();
                  },
                  child: Text("Envoyer",textAlign: TextAlign.center,style: 
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "Times New Roman"
                  ),),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            gradient:LinearGradient(
              colors: [
               Colors.red,
               Colors.deepOrangeAccent,
              ],
            ),
          ),
          child: Text("© Orange 2024",textAlign: TextAlign.center,style: TextStyle(
            fontSize: 18,
          ),),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                 child: Icon(Icons.money_off_rounded,color:Colors.red,size: 50,),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Orange',style: TextStyle(
                    fontFamily: "Times New Roman",
                  ),),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Administrateur',style: TextStyle(
                    fontFamily: "Times New Roman",
                  ),),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.contact_emergency),
                  title: Text('694497512',style: TextStyle(
                    fontFamily: "Times New Roman",
                  ),),
                ),
                ListTile(
                  onTap: () {
                    _showHelpDialog();
                  },
                  leading: Icon(Icons.info),
                  title: Text('Propos',style: TextStyle(
                    fontFamily: "Times New Roman",
                  ),),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('© Orange 2024',style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 18,
                  ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
  );
  }
   void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
  void _showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromCircle(
          center: Offset(MediaQuery.of(context).size.width - 50, 75),
          radius: 10,
        ),
        Offset.zero & MediaQuery.of(context).size,
      ),
      items: [
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              _showHelpDialog();
            },
            child: Text("Aide"),
          ),
        ),
      ],
    );
  }
 void envoyerArgent() {
  String destinataire = destinataireController.text;
  String montant = montantController.text;
  String codeConfirmation = codeConfirmationController.text;

  String ussdCode = '#150*1*1*$destinataire*$montant*$codeConfirmation#';
  String url = 'tel:$ussdCode';

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Connexion à Orange Money en cours..."),
          ],
        ),
      );
    },
  );

  // Delay the execution of launch by 10 seconds
  Future.delayed(Duration(seconds: 10), () async {
    // Close the loading dialog
    Navigator.pop(context);

    // Execute the launch function
    await launch(url);
  });
}
void _showHelpDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Aide"),
        content: Builder(
          builder: (BuildContext context) {
            // Check if the "Propos" option is selected
            if (_isAboutOptionSelected(context)) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Cette application vous permet de transférer d'argent à des utilisateurs Orange via Orange Money sans composer des codes.",
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Développeur: Ahmadou Tidjani",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      // Open the developer's GitHub profile
                      launch("https://github.com/AhmadouTidjani37");
                    },
                    child: Text(
                      "GitHub: https://github.com/AhmadouTidjani37",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              );
            } else {
              return Text(
                "Cette application vous permet de transférer de l'argent à des utilisateurs Orange via Orange Money.",
              );
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Fermer"),
          ),
        ],
      );
    },
  );
}

// Helper method to check if the "Propos" option is selected
bool _isAboutOptionSelected(BuildContext context) {
  // Implement the logic to check if the "Propos" option is selected
  // For example, you can check the current route or any other condition
  // Here, I'm assuming you have a specific condition to identify the "Propos" option
  return true; // Change this condition based on your app's logic
}

}