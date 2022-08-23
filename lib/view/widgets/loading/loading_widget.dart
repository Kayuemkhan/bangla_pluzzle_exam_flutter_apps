import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 180,
        height: 100,
        padding: const EdgeInsets.all(0),
        child: Image.asset('assets/gif/waiting.gif'),
      ),
    );
  }
}

showLoading() {
  BotToast.showCustomLoading(toastBuilder: (close) {
    return LoadingWidget();
  });
}

stopLoading() {
  BotToast.closeAllLoading();
}



