import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/login_controller/login_cubit.dart';
import 'package:social_app/controllers/login_controller/login_states.dart';
import 'package:social_app/controllers/posts_controller/posts_bloc.dart';
import 'package:social_app/controllers/user_controller/user_bloc.dart';
import 'package:social_app/data/repository/auth_repos/auth_repository.dart';
import 'package:social_app/presentation/register/register_screen.dart';
import 'package:social_app/presentation/home_layout/home_layout.dart';
import 'package:social_app/utils/components/components.dart';
import 'package:social_app/utils/components/regular_form_field.dart';
import 'package:social_app/utils/consistent/consistent.dart';
import 'package:social_app/utils/network/local/shared_prefrences/cached_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(loginRepository: AuthRepository()),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CachedHelper.savePref(key: 'uId', value: state.uId).then((value) {
              currentUserId = CachedHelper.getPref(key: 'uId');
              myToast(msg: 'success', state: toastStates.success);
              navigateAndRemove(context, const HomeLayout());
              context.read<UserBloc>().add(LoadUserEvent());
              context.read<PostsBloc>().add(LoadPostsEvent());
            });
          }
          if (state is LoginErrorState) {
            myToast(msg: state.error.split(']')[1], state: toastStates.error);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Log in to catch up with the best deals',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          const SizedBox(height: 40),
                          myFormField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            icon: const Icon(Icons.email_rounded),
                            title: 'Email Address',
                            validateText: 'Enter Email Address',
                          ),
                          const SizedBox(height: 20),
                          myFormField(
                              type: TextInputType.visiblePassword,
                              controller: passwordController,
                              icon: const Icon(Icons.lock_outline),
                              title: 'Password',
                              validateText: 'Password is too short',
                              isObscure: cubit.isObscure,
                              suffix: IconButton(
                                onPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                                icon: Icon(
                                  cubit.isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                  size: 22,
                                ),
                              ),
                              onSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  cubit.loginUserIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          const SizedBox(height: 20),
                          myElevatedButton(
                            context,
                            width: double.maxFinite,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.loginUserIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: state is LoginLoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('LOGIN'),
                            borderCircular: 15,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                child: const Text('REGISTER'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
