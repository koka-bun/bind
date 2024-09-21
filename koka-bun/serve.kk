module koka-bun/serve

import koka-bun/js

pub struct headers

pub struct request
  method: string
  url: string
  headers: headers
  body: maybe<string>

pub struct response
  body: maybe<string> = Nothing
  status: int = 200
  headers: maybe<headers> = Nothing

pub struct options
  port: maybe<int>

pub fun options( port : maybe<int> ) : maybe<options>
  Just(Options(
    port = port
  ))

pub val serve: (maybe<options>, (request) -> response) -> io unit
  = require("koka-bun/serve.ts")
