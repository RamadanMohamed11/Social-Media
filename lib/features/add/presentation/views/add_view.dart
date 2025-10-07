import 'package:flutter/material.dart';
import 'package:social_media/features/add/presentation/views/widgets/add_view_model.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddViewModel());
  }
}
