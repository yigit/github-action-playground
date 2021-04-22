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
    implementation("io.ktor:ktor-server-core:1.5.3")
    implementation("io.ktor:ktor-server-netty:1.5.3")
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