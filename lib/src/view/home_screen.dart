import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:users_directory/src/model/user.dart';
import 'package:users_directory/src/view/user_details_screen.dart';
import 'package:users_directory/src/controller/users_provider/users_provider.dart';
import 'package:users_directory/src/controller/users_provider/users_state_notifier.dart';
import 'package:users_directory/src/controller/brightness_provider.dart/brightness_provider.dart';
import 'package:users_directory/src/controller/brightness_provider.dart/brightness_state_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(usersNotifierProvider);
    UsersNotifier usersProvider = ref.read(usersNotifierProvider.notifier);

    BrightnessNotifier brightnessProvider = ref.read(brightnessNotifierProvider.notifier);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users Directory'),
          actions: [
            IconButton(
              onPressed: () => brightnessProvider.toggleBrightness(),
              icon: Icon(brightnessProvider.brightness == Brightness.light ? Icons.dark_mode : Icons.light_mode),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: state.when(
            initial: (data) => Column(
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: TextField(
                        controller: usersProvider.searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search, size: 24),
                          suffixIcon: GestureDetector(
                            child: const Icon(
                              Icons.close_rounded,
                              size: 24,
                            ),
                            onTap: () {
                              usersProvider.searchController.clear();
                              usersProvider.filteredUsersList = usersProvider.usersList;
                              FocusScope.of(context).unfocus();
                            },
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          usersProvider.filterUsers(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: usersProvider.filteredUsersList.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final User item = data[index];
                          return InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return UserDetailsScreen(user: item);
                            })),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                CachedNetworkImage(
                                  imageUrl: item.picture.thumbnail,
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Padding(
                                        padding: EdgeInsets.all(4), child: CircularProgressIndicator(strokeWidth: 3)),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${item.name.title} ${item.name.first} ${item.name.last}',
                                        style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 2),
                                    Text(item.email, style: Theme.of(context).textTheme.bodyMedium),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 16),
                                const SizedBox(width: 16),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e) => Center(
                    child: Column(
                  children: [
                    const Icon(Icons.error_outline),
                    const SizedBox(height: 8),
                    Text(e.toString()),
                  ],
                ))),
      ),
    );
  }
}
