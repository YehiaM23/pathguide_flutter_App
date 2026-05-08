import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/recruiter/internships/presentation/bloc/internship_bloc.dart';
import 'features/recruiter/applications/presentation/bloc/application_bloc.dart';
import 'features/recruiter/applications/presentation/bloc/application_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PathGuideApp());
}

class PathGuideApp extends StatelessWidget {
  const PathGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AppStarted())),
        BlocProvider(create: (context) => InternshipBloc()..add(LoadMyInternships())),
        BlocProvider(create: (context) => ApplicationBloc()..add(LoadApplications())),
      ],
      child: MaterialApp.router(
        title: 'PathGuide',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
