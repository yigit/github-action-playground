package com.birbit.actions.github.sample

import io.ktor.application.*
import io.ktor.features.DefaultHeaders
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*

fun Application.main() {

    install(DefaultHeaders)
//        install(ShutDownUrl.ApplicationCallFeature) {
//            shutDownUrl = "/shutdown"
//            exitCodeSupplier = { 0 }
//        }
    routing {
        get("/") {
            println("RECEIVED QUERY ${call.request.queryParameters}")
            val response = call.parameters.entries().joinToString(" ") {
                ":${it.key}-${it.value}:"
            }
            call.respondText(response)
        }
    }
}