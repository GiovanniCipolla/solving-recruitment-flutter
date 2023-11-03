import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';

class CustomButtonAdd extends StatelessWidget {
  const CustomButtonAdd(
      {super.key,
      required this.titleShowDialog,
      required this.descrizioneShowDialog,
      required this.metodoShowDialog});

  final String titleShowDialog;
  final String descrizioneShowDialog;
  final dynamic metodoShowDialog;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  showConfirmationDialog(context, titleShowDialog,
                      descrizioneShowDialog, metodoShowDialog);
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: heightSize(context) * 0.02,
              )
            ],
          ),
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
        ],
      );
}
