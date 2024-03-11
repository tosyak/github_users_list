import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:github_test_app/app/app_router.dart';
import 'package:github_test_app/bloc/user_details_bloc/user_details_bloc_bloc.dart';
import 'package:github_test_app/bloc/users_list_bloc/users_list_bloc_bloc.dart';
import 'package:github_test_app/data/models/user_model.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    super.dispose();
  }

  void onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<UsersListBloc>().add(GetUsersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.usersList),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.pushNamed(PAGES.settings.screenName),
            ),
          ],
        ),
        body: BlocBuilder<UsersListBloc, UsersListState>(
          builder: (context, state) {
            switch (state.status) {
              case UserStatus.loading:
                return const LoadingWidget();
              case UserStatus.success:
                if (state.users.isEmpty) {
                  return const Center(
                    child: Text("No Users"),
                  );
                }
                return ListView.builder(
                  controller: scrollController,
                  itemCount: state.hasReachedMax
                      ? state.users.length
                      : state.users.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.users.length
                        ? const LoadingWidget()
                        : UserListItem(user: state.users[index]);
                  },
                );
              case UserStatus.error:
                return Center(
                  child: Text(state.errorMessage),
                );
            }
          },
        ));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  const UserListItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: SizedBox(
        child: ListTile(
          onTap: () {
            context
                .read<UserDetailsBloc>()
                .add(GetUserDetailsEvent(user.login));
            context.goNamed(PAGES.userDetails.screenName);
          },
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          leading: CircleAvatar(
            radius: 24.0,
            child: CircleAvatar(
              radius: 22.0,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
          ),
          title: Text(user.login),
        ),
      ),
    );
  }
}
