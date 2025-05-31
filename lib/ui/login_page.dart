import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/activity_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/navigation_bloc.dart';
import 'activity_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AssetsSuccess) {
                context.read<ActivityBloc>().add(
                  LoadActivityWithData(
                    state.assets,
                  ), // assuming you have it in state
                );
                context.read<NavigationBloc>().add(NavigateToActivityPage());
              } else if (state is AuthSuccess) {
                context.read<AuthBloc>().add(
                  FetchSampleAssets(state.accessToken),
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<NavigationBloc, NavigationState>(
            listener: (context, state) {
              if (state is NavigateToActivityState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ActivityPage()),
                );
              }
            },
          ),
        ],
        child: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state is AuthLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignInWithGoogle());
                      },
                      child: const Text("Sign in with Google"),
                    );
            },
          ),
        ),
      ),
    );
  }
}
