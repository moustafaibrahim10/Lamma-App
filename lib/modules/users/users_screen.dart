import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_app/cubit/cubit.dart';

import '../../cubit/states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(
      builder: (context, state) {
        final cubit = SocialCubit.get(context);
        final markers = cubit.users
            .where((u) => u.lat != null && u.long != null)
            .map((user) {
          return Marker(
            markerId: MarkerId(user.uId!),
            position: LatLng(user.lat ?? 0, user.long ?? 0),
            infoWindow: InfoWindow(title: user.name, snippet: user.bio),
          );
        }).toSet();
        return GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
              target: LatLng(30.0444, 31.2357), // cairo
              zoom: 10
          ),
          markers: markers ,
        );
      },
    );
  }
}
