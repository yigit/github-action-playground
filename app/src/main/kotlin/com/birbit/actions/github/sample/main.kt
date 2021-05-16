package com.birbit.actions.github.sample
import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
fun main(args: Array<String>) {
    println("hello ${args.joinToString(",")}")
    embeddedServer(Netty, port = 8123) {
        install(ShutDownUrl.ApplicationCallFeature) {
            shutDownUrl = "/shutdown"
            exitCodeSupplier = { 0 }
        }
        routing {
            get("/") {
                val response = call.parameters.entries().joinToString(" ") {
                    "${it.key}-${it.value}"
                }
                call.respondText(response)
            }
        }
    }.start(wait = true)
}