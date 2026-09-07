/// OAuth client IDs from Firebase `google-services.json` / Google Cloud.
class GoogleOAuthConfig {
  GoogleOAuthConfig._();

  /// Web client (client_type 3) — use as [GoogleSignIn] serverClientId.
  static const String webClientId =
      '96250300840-9afaam17misoakmrp8rtjaeh3msishtj.apps.googleusercontent.com';

  /// Android client (client_type 1).
  static const String androidClientId =
      '96250300840-97nlskp4eplntu225qamqj49ho8uj04b.apps.googleusercontent.com';

  /// iOS client (client_type 2).
  static const String iosClientId =
      '96250300840-757efd405ptsa3bidatgmt4kigmo4nfj.apps.googleusercontent.com';
}
