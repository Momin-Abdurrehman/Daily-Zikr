# Flutter-specific rules
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# flutter_local_notifications
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

# Gson (used internally by flutter_local_notifications)
-keep class com.google.gson.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
