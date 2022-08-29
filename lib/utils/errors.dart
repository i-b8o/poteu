import 'package:sentry_flutter/sentry_flutter.dart';

sendError(Object exception, StackTrace stackTrace) async {
  await Sentry.captureException(
    exception,
    stackTrace: stackTrace,
  );
}
