import koka-bun/file
import koka-bun/serve
import koka-bun/ext/async

fun load-self(): <async,ndet> string
  val out = try fn()
    file/new("test/main.kk").text
  match out
    Ok(t) -> t
    Error(e) -> e.show

fun main()
  load-self()
