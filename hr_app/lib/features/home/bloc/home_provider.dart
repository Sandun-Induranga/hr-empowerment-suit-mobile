import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_bloc.dart';

class HomeProvider extends BlocProvider<HomeBloc> {
  HomeProvider({
    super.key,
  }) : super(
          create: (context) => HomeBloc(),
        );
}
