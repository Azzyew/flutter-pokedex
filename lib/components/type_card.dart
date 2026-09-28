import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget {
  final int id;

  const TypeCard({
    super.key,
    required this.id,
  });

  final String _baseImgUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/types/generation-viii/legends-arceus/';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('cliquei');
      },
      child:
        Row(
          children: [
            Image.network('$_baseImgUrl$id.png'),
          ],
        ),
    );
  }
}

// Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 side: const BorderSide(color: MyColorsSample.primary, width: 2,),
//               ),
//               elevation: 0,
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               child: Container(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text("Card Outlined", style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.grey[800]
//                     ),),
//                     Container(height: 10),
//                     Text(MyStringsSample.card_text, style: TextStyle(
//                         fontSize: 15, color: Colors.grey[700]
//                     )),
//                     Container(height: 10),
//                   ],
//                 ),
//               ),