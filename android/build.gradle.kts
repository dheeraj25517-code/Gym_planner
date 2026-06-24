allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.layout.buildDirectory.set(rootProject.file("../build"))

subprojects {
    project.layout.buildDirectory.set(rootProject.layout.buildDirectory.dir(project.name))
    
    // Core function to safely force compileSdk to 34
    val forceCompileSdk = {
        if (project.plugins.hasPlugin("com.android.application") || project.plugins.hasPlugin("com.android.library")) {
            val androidExtension = project.extensions.findByName("android") as? com.android.build.gradle.BaseExtension
            androidExtension?.apply {
                compileSdkVersion(35)
            }
        }
    }

    // Lifecycle guard: Check if the subproject is already evaluated
    if (project.state.executed) {
        forceCompileSdk()
    } else {
        project.afterEvaluate { forceCompileSdk() }
    }
}

// Ensure evaluation dependencies are declared at the very end of the file
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}