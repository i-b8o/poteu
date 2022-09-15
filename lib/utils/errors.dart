import 'package:sentry_flutter/sentry_flutter.dart';

sendError(Object exception, StackTrace stackTrace, String message) async {
  Sentry.captureMessage(message);
  await Sentry.captureException(
    exception,
    hint: "",
    stackTrace: stackTrace,
  );
}
