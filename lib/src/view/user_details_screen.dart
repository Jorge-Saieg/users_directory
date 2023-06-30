import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:users_directory/src/model/user.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 84,
                    width: 84,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: user.picture.large,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const SizedBox(
                        width: 30,
                        height: 30,
                        child: Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator(strokeWidth: 3)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text('${user.name.title} ${user.name.first} ${user.name.last}',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Text(user.gender, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 2),
                      Text(user.dob.age.toString(), style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Birthday', style: Theme.of(context).textTheme.titleMedium)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.cake_rounded, color: Colors.grey, size: 16),
                  const SizedBox(width: 8),
                  Text(DateFormat.yMMMMd().format(DateTime.parse(user.dob.date)),
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Contact', style: Theme.of(context).textTheme.titleMedium)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  String url = 'tel:${user.cell}';
                  Uri uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Cannot call ${user.phone}';
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.phone_android_rounded, color: Colors.grey, size: 16),
                    const SizedBox(width: 8),
                    Text(user.phone, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String url = 'tel:${user.phone}';
                  Uri uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Cannot call ${user.phone}';
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.call_rounded, color: Colors.grey, size: 16),
                    const SizedBox(width: 8),
                    Text(user.phone, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String url = 'mailto:${user.email}';
                  Uri uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Cannot send to ${user.email}';
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.mail_rounded, color: Colors.grey, size: 16),
                    const SizedBox(width: 8),
                    Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    Text('${user.location.street.name} ${user.location.street.number}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text('${user.location.state}, ${user.location.city}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(user.location.country, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
