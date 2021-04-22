plugins {
    application
    kotlin("jvm") version "1.4.20"
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
}

application {
    applicationName = "app"
    mainClass.set("com.birbit.actions.github.sample.MainKt")
}

tasks.named<Sync>("installDist").configure {
    this.destinationDir = project.projectDir.resolve("../dist")
}
tasks.register("buildAppDist", Copy::class.java) {
    into(projectDir.resolve("dist"))
}