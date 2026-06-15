plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

android {
    namespace = "com.courierx.merchant"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.courierx.merchant"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
//    signingConfigs {
//        create("release") {
//            keyAlias = keystoreProperties["keyAlias"] as String?
//            keyPassword = keystoreProperties["keyPassword"] as String?
//            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
//            storePassword = keystoreProperties["storePassword"] as String?
//        }
//    }
    buildTypes {
        release {
            // Configure your own release signing key before publishing to app stores.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}




