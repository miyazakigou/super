import java.util.Properties
import java.io.File

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// 安全に key.properties を読み込む
val keystoreProperties = Properties().apply {
    val kpFile = File(rootProject.projectDir, "key.properties")
    if (kpFile.exists()) {
        kpFile.inputStream().use { load(it) }
    }
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
        create("release") {
            // keystoreProperties を安全に参照（存在しない場合はデフォルトを使う）
            val alias = keystoreProperties.getProperty("keyAlias") ?: ""
            val keyPass = keystoreProperties.getProperty("keyPassword") ?: ""
            val storeName = keystoreProperties.getProperty("storeFile") ?: "my-release-key.keystore"
            val storePass = keystoreProperties.getProperty("storePassword") ?: ""

            keyAlias = alias
            keyPassword = keyPass
            storeFile = file(storeName)
            storePassword = storePass
        }
    }

    buildTypes {
    debug {
        signingConfig = signingConfigs.getByName("debug")
        isMinifyEnabled = false
        isShrinkResources = false
    }
    release {
        signingConfig = signingConfigs.getByName("release")
        isMinifyEnabled = true
        isShrinkResources = true
    }
}

}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.gms:play-services-auth:20.7.0")
}

apply(plugin = "com.google.gms.google-services")
