import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/global/widgets/custom_app_bar.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_colors_light.dart';
import '/features/slots/model/models/user_slots_model.dart';
import '/features/slots/viewmodel/user_slots_cubit.dart';

import 'widgets/user_slots_success_widget.dart';

class SlotsView extends StatefulWidget {
  const SlotsView({super.key});

  @override
  State<SlotsView> createState() => _SlotsViewState();
}

class _SlotsViewState extends State<SlotsView> {
  final UserSlotsCubit _cubit = sl<UserSlotsCubit>();

  @override
  void initState() {
    _cubit.init();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserSlotsCubit>(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: CustomAppBar(
          haveLogout: true,
          logoutOnPressed: () {
            _cubit.logoutDialog();
          },
          refreshOPressed: () {
            _cubit.refresh();
          },
        ),
        body: BlocBuilder<UserSlotsCubit, UserSlotsState>(
          bloc: _cubit,
          builder: (context, state) {
            if (_cubit.userSlotsModel == null && _cubit.error.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kOtpButtonColor,
                ),
              );
            }
            return UserSlotsSuccessWidget(
              userSlotsModel:
                  _cubit.userSlotsModel ?? const UserSlotsModel(data: []),
            );
          },
        ),
      ),
    );
  }
}
