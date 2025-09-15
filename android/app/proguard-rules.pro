# Flutter and Dart keep rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }

# Firebase keep rules (Auth, Firestore, Storage)
-keepattributes *Annotation*
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Kotlin coroutines and stdlib
-dontwarn kotlinx.coroutines.**

# OkHttp/Gson common rules (transitive deps)
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn com.google.gson.**

# Keep app model classes if used via reflection
-keep class com.example.my_chat_app.** { *; }

