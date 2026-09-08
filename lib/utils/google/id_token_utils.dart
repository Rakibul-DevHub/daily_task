import 'dart:convert';

class IdTokenUtils {
  IdTokenUtils._();

  static String? audience(String idToken) {
    try {
      final parts = idToken.split('.');
      if (parts.length != 3) return null;

      final normalized = base64Url.normalize(parts[1]);
      final payload = jsonDecode(utf8.decode(base64Url.decode(normalized)));
      if (payload is! Map) return null;

      return payload['aud']?.toString();
    } catch (_) {
      return null;
    }
  }
}
