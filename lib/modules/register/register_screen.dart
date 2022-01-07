import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/Home_layout.dart';
import 'package:social_app/modules/register/cubit/register_cubit.dart';
import 'package:social_app/modules/register/cubit/register_states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/consistent/consistent.dart';
import 'package:social_app/shared/network/local/shared_prefrences/cached_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterUserCreateSuccessState) {
            CachedHelper.savePref(key: 'uId', value: state.uId).then((value) {
              currentUserId = CachedHelper.getPref(key: 'uId');
            });
            navigateAndRemove(context, const HomeLayout());
          }
          if (state is RegisterErrorState) {
            myToast(msg: state.error.split(']')[1], state: toastStates.error);
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
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
                            type: TextInputType.name,
                            controller: nameController,
                            icon: const Icon(Icons.person),
                            title: 'Name',
                            validateText: 'name must be not empty',
                          ),
                          const SizedBox(height: 10),
                          myFormField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            icon: const Icon(Icons.email_rounded),
                            title: 'Email Address',
                            validateText: 'Enter Email Address',
                          ),
                          const SizedBox(height: 10),
                          myFormField(
                            type: TextInputType.phone,
                            controller: phoneController,
                            icon: const Icon(Icons.phone),
                            title: 'Phone Number',
                            validateText: 'Phone Number must not be empty',
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
                                  cubit.userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      name: nameController.text);
                                }
                              }),
                          const SizedBox(height: 20),
                          myElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text);
                              }
                            },
                            child: state is RegisterUserCreateLoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('REGISTER'),
                            borderCircular: 10,
                          ),
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
