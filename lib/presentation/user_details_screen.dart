import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:github_test_app/app/app_router.dart';
import 'package:github_test_app/bloc/user_details_bloc/user_details_bloc_bloc.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.userDetails),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed(PAGES.settings.screenName),
          ),
        ],
      ),
      body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          if (state is GithubUserDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDetailsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 77,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(state.user.avatarUrl ?? ''),
                      radius: 70.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text("Name: "),
                      Text(state.user.name ?? ''),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text("Login: "),
                      Text(state.user.login),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text("Location: "),
                      Text(state.user.location ?? ''),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text("Public Repos: "),
                      Text(state.user.publicRepos.toString()),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text("Folowers: "),
                      Text(state.user.followers.toString()),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text("Created At: "),
                      Text(DateFormat('dd MMMM yyyy')
                          .format(state.user.createdAt!)
                          .toString()),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            );
          } else if (state is UserDetailsError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
