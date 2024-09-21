module koka-bun/file

pub import koka-bun/js
import koka-bun/ext/async

pub struct file

pub extern file/new(path: string): file
  js inline "Bun.file(#1)"

pub fun file/text(file: file): asyncx string
  js-promise/wrap(file.text-promise)

pub extern file/text-promise(file: file): js-promise<string>
  js inline "#1.text()"
