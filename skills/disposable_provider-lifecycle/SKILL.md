---
name: disposable_provider-lifecycle
description: >-
  Use when injecting non-ChangeNotifier service or state classes into the Flutter widget tree
  and ensuring automatic resource cleanup upon unmounting using disposable_provider.
---

# disposable_provider Lifecycle & Injection Guide

`disposable_provider` is a lightweight extension of `package:provider`. It provides objects that implement the `Disposable` interface to widget subtrees and automatically invokes their `.dispose()` method when the provider is removed from the widget tree.

## Guidelines

- **Implement `Disposable`**:
  - Make your service or controller class implement `Disposable` from `package:disposable_provider/disposable_provider.dart`.
  - Override `void dispose()` to clean up stream controllers, HTTP connections, or database handles.
- **Providing Instances**:
  - Wrap the target subtree with `DisposableProvider<T>(create: (context) => T(), child: ...)`.
  - Unlike raw `Provider<T>`, `DisposableProvider` automatically passes `dispose: (_, obj) => obj.dispose()` to prevent manual cleanup omissions.
- **Reading Instances**:
  - Call `DisposableProvider.of<T>(context)` to retrieve the instance with `listen: false`.
  - Alternatively, use `context.read<T>()` or `Provider.of<T>(context, listen: false)`.

## Examples

### 1. Defining a Disposable Service

```dart
import 'dart:async';
import 'package:disposable_provider/disposable_provider.dart';

class LocationTrackingService implements Disposable {
  LocationTrackingService() {
    _initTracking();
  }

  final _locationController = StreamController<String>.broadcast();
  Stream<String> get locationStream => _locationController.stream;

  void _initTracking() {
    // Start tracking logic
  }

  @override
  void dispose() {
    _locationController.close();
    print('LocationTrackingService cleanly disposed');
  }
}
```

### 2. Injecting and Consuming in the Widget Tree

```dart
import 'package:disposable_provider/disposable_provider.dart';
import 'package:flutter/material.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DisposableProvider<LocationTrackingService>(
      create: (context) => LocationTrackingService(),
      child: const _TrackingView(),
    );
  }
}

class _TrackingView extends StatelessWidget {
  const _TrackingView();

  @override
  Widget build(BuildContext context) {
    // Access with DisposableProvider.of
    final service = DisposableProvider.of<LocationTrackingService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Live Tracking')),
      body: StreamBuilder<String>(
        stream: service.locationStream,
        builder: (context, snapshot) {
          return Center(
            child: Text(snapshot.data ?? 'Waiting for coordinates...'),
          );
        },
      ),
    );
  }
}
```

## Common Pitfalls & Anti-Patterns

- ❌ **Anti-pattern**: Using raw `Provider<T>(create: (_) => MyService())` without specifying `dispose: (_, s) => s.dispose()`, causing services to remain active in memory after the page is popped.
  - ✔️ **Correct**: Use `DisposableProvider<T>` whenever `T` implements `Disposable`.
- ❌ **Anti-pattern**: Using `DisposableProvider` for `ChangeNotifier` classes.
  - ✔️ **Correct**: Use Flutter's built-in `ChangeNotifierProvider` for `ChangeNotifier` subclasses. Use `DisposableProvider` for classes that don't depend on Flutter's notification framework but require explicit teardown.
