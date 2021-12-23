module Main

%foreign "browser:lambda:x=>{document.body.innerHTML = x}"
prim__setBodyInnerHTML : String -> PrimIO ()

setBodyInnerHtml : HasIO io => String -> io ()
setBodyInnerHtml = primIO . prim__setBodyInnerHTML

%foreign "javascript:lambda:(callback, delay)=>setTimeout(callback, delay)"
prim__setTimeout : (PrimIO ()) -> Int32 -> PrimIO ()

setTimeout : HasIO io => IO () -> Int32 -> io ()
setTimeout callback delay = primIO $ prim__setTimeout (toPrim callback) delay

%foreign "browser:lambda: x => console.log(x)"
prim__consoleLog : String -> PrimIO ()

consoleLog : HasIO io => String -> io ()
consoleLog x = primIO $ prim__consoleLog x

main : IO ()
main = do 
  consoleLog "Hello from Idris!"
  setBodyInnerHtml "<i>This part is written by main.idr.</i>"
