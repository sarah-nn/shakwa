pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

// ⚠️ التعديل هنا: إضافة اعتماد Desugaring إلى كتلة 'plugins'
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.0" apply false
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version("4.3.15") apply false
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
    
    // 💡 إضافة اعتماد Desugaring هنا كـ 'classpath'
    // يتم تعريف هذا عادةً في ملف build.gradle.kts للجذر (وهو غير موجود لديك)، لذا نضعه هنا:
    // ** ملاحظة: لا يمكننا تعريف classpath مباشر هنا. يجب نقله إلى ملف الجذر. **
}

include(":app")