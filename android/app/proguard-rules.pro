# flutter_local_notifications stores scheduled notifications with Gson, which
# needs generic type signatures that R8 strips by default.
-keepattributes Signature
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keep class com.dexterous.** { *; }
