import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silk_innovation_susan/provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flipCardController = FlipCardController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CardProvider>().initial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Card Guess'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Consumer<CardProvider>(
              builder: (context, provider, child) {
                if (provider.isMatch == 'notMatch') {
                  Future.delayed(
                      const Duration(
                        milliseconds: 1600,
                      ), () {
                    provider.cardKeys[provider.indexFirst].currentState!
                        .toggleCard();
                    provider.cardKeys[provider.indexSecond].currentState!
                        .toggleCard();
                    provider.changeNormal();
                  });
                }

                if (provider.isCompelete) {
                  return Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              context.read<CardProvider>().initial();
                            },
                            child: const Text('Do you went to play again?')),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      mainAxisExtent: 180),
                  itemCount: provider.suff.length,
                  itemBuilder: (cxt, i) {
                    return Visibility(
                      visible: !provider.suff[i].isMatch,
                      child: FlipCard(
                        side: CardSide.FRONT,
                        key: provider.cardKeys[i],
                        flipOnTouch:
                            !provider.isAwait && !provider.suff[i].isClick,
                        onFlip: !provider.isAwait
                            ? () {
                                context.read<CardProvider>().onTap(i);
                              }
                            : null,
                        front: const Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(child: Text("?")),
                          ),
                        ),
                        back: Image.asset(
                          provider.suff[i].imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
