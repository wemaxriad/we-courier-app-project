# WeCourier Merchant Mobile App

The WeCourier Merchant Mobile App is the Flutter source code for merchants who manage parcels, invoices, payment requests, wallet balances, shops, support tickets, and parcel tracking from a mobile device.

## Requirements

- Flutter SDK 3.x or later
- Dart SDK compatible with the Flutter version
- Android Studio or VS Code with Flutter tooling
- A running WeCourier web application/API
- Firebase project for push notifications
- Google Maps API key if map/address features are enabled

## Setup

1. Run `flutter pub get`.
2. Configure the API base URL and API key in `lib/services/api-list.dart`.
3. Replace Firebase configuration files with your own project configuration.
4. Configure Android/iOS package IDs, app name, icons, and signing keys before publishing.
5. Run `flutter run` to test the app.

## External Services

Firebase, Google Maps, SMS gateways, and payment gateways may require separate accounts, API keys, paid subscriptions, or usage-based billing. These external costs are not included with the item.
