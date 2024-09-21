module koka-bun/js

import koka-bun/ext/async

pub struct js-promise<t>

abstract extend type exception-info
  con Catch(error: any)

pub fun js-promise/wrap(promise: js-promise<t>): asyncx t
  setup/await fn(cb)
    promise.on-resolve(fn(output) cb(Ok(output)), fn(error) cb(Error(Exception("Exception in promise.", Catch(error)))))
    Nothing

pub inline extern js-promise/on-resolve(promise: js-promise<t>, success: (t) -> e u, error: (any) -> e ()): e js-promise<u>
  js inline "#1.then(#2).catch(#3)"

pub inline extern require(path: string): a
  js inline "require('./' + #1).default"
