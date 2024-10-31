import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/design-system/tokens/spacing.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/create_pet_form_widget.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_cubit.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/modules/create-pet/presentation/widgets/types/form_field_data.dart';
import 'package:meopets/src/shared/widgets/custom_app_bar.dart';
import 'package:meopets/src/shared/widgets/loading_component.dart';
import 'package:meopets/src/shared/widgets/custom_toaster.dart';

class CreatePetScreen extends StatefulWidget {
  const CreatePetScreen({super.key});

  @override
  State<CreatePetScreen> createState() => _CreatePetScreenState();
}

class _CreatePetScreenState extends State<CreatePetScreen> {
  CreatePetCubit get _createPetCubit => context.read<CreatePetCubit>();
  final List<FormFieldData> _formFields = createPetformFields;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePetCubit, CreatePetState>(
      listener: (context, state) {
        if (state.status == CreatePetStatus.successfullyCreated) {
          _navigateToMyPets();
        }
        if (state.status == CreatePetStatus.error) {
          _showError();
        }
      },
      builder: (context, state) {
        if (state.status == CreatePetStatus.loading) {
          return const LoadingComponent();
        } else {
          return _buildScaffold();
        }
      },
    );
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(SpacingTokens.md),
        child: CreatePetFormWidget(
          formFields: _formFields,
          onSubmit: _onFormSubmit,
        ),
      ),
    );
  }

  void _onFormSubmit(List<FormFieldData> formFields) {
    final Map<String, dynamic> formData = {
      for (var item in createPetformFields) item['key']: item['value']
    };

    _createPetCubit.createPet(formData);
  }

  void _navigateToMyPets() {
    Navigator.of(context).pop();
  }

  void _showError() {
    CustomToaster.showErrorToast('Erro ao criar pet');
  }
}
