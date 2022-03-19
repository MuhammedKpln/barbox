import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';

import 'cubits/AccountCubit.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void logout() {
      BlocProvider.of<AccountCubit>(context).logout();
      Navigator.of(context).pop();
    }

    return MacosScaffold(
      titleBar: const TitleBar(
        title: Text("Settings"),
      ),
      children: [
        ContentArea(
          minWidth: double.infinity,
          builder: (context, scrollController) {
            return BlocConsumer<AccountCubit, AccountInitial>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AccountLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Text(state.account.adress
                              .substring(0, 2)
                              .toUpperCase()),
                          minRadius: 50,
                          maxRadius: 50,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: PushButton(
                            child: const Text("Logout"),
                            buttonSize: ButtonSize.large,
                            isSecondary: true,
                            onPressed: logout,
                          ),
                        )
                      ],
                    );
                  }

                  return const ProgressCircle();
                });
          },
        )
      ],
    );
  }
}
