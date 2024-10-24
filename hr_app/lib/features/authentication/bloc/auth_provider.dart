import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_bloc.dart';

class AuthProvider extends BlocProvider<AuthBloc> {
  AuthProvider({
    super.key,
  }) : super(
          create: (context) => AuthBloc(),
        );
}
