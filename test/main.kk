import koka-bun/serve

fun main()
  val serve-options = options(
    port = Just(3000)
  )
  println("Listening on port 3000")
  with request <- serve(serve-options)
  Response(Just("Hello, World!"))
