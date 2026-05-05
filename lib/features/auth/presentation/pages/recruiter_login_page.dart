import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';
import '../bloc/auth_bloc.dart';

class RecruiterLoginPage extends StatefulWidget {
  const RecruiterLoginPage({super.key});

  @override
  State<RecruiterLoginPage> createState() => _RecruiterLoginPageState();
}

class _RecruiterLoginPageState extends State<RecruiterLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated && state.user.role == UserRole.recruiter) {
          context.go('/recruiter/dashboard');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.dangerRed),
          );
        }
      },
      child: PageScaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PathGuideLogo(size: 48, showTagline: true),
              const SizedBox(height: 48),
              _buildHeader(),
              const SizedBox(height: 32),
              _buildLoginCard(context),
              const SizedBox(height: 32),
              _buildFooterLinks(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.lightPurple,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.business_center, color: AppColors.primaryBlue, size: 18),
              SizedBox(width: 8),
              Text(
                'Recruiter Portal',
                style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(
          title: 'Partner Login',
          subtitle: 'Sign in to find top talent for your team',
          centered: true,
        ),
      ],
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: 'Business Email',
            hint: 'name@company.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: (val) => val != null && val.contains('@') ? null : 'Enter a valid email',
          ),
          const SizedBox(height: 24),
          AppTextField(
            label: 'Password',
            hint: 'Enter your password',
            controller: _passwordController,
            isPassword: true,
            prefixIcon: Icons.lock_outline,
            validator: (val) => val != null && val.length >= 6 ? null : 'Password must be at least 6 characters',
          ),
          const SizedBox(height: 32),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return GradientButton(
                text: 'Sign In',
                isLoading: state is AuthLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          LoginRequested(_emailController.text, _passwordController.text, 'recruiter'),
                        );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLinks(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => context.push('/signup'),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(color: AppColors.mutedText, fontFamily: 'Poppins', fontSize: 15),
              children: [
                TextSpan(text: "Don't have an account? "),
                TextSpan(
                  text: "Register Now", 
                  style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Divider(color: AppColors.cardBorder, indent: 40, endIndent: 40),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => context.push('/student-login'),
          child: const Text(
            'Are you a student? Switch to Student Login',
            style: TextStyle(color: AppColors.mutedText, fontSize: 14),
          ),
        ),
      ],
    );
  }
}


