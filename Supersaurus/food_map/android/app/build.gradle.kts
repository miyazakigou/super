plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.food_map"
    compileSdk = 36
    defaultConfig {
        applicationId = "com.example.food_map"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }
    signingConfigs {
        release {
            storeFile file("my-release-key.keystore")
            storePassword "123456"
            keyAlias "my-key-alias"
            keyPassword "123456"
        }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}

apply(plugin = "com.google.gms.google-services")

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.gms:play-services-auth:20.7.0")
}
