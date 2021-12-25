module Main

%foreign "browser:lambda:x=>{document.body.innerHTML = x}"
prim__setBodyInnerHTML : String -> PrimIO ()

setBodyInnerHtml : HasIO io => String -> io ()
setBodyInnerHtml = primIO . prim__setBodyInnerHTML

%foreign "browser:lambda: x => console.log(x)"
prim__consoleLog : String -> PrimIO ()

consoleLog : HasIO io => String -> io ()
consoleLog x = primIO $ prim__consoleLog x

main : IO ()
main = do 
  consoleLog "Hello from Idris!"
  let n = S (S (S Z))
  consoleLog $ show n
  setBodyInnerHtml $ "<i>This part is written by main.idr.</i> " ++ "<p><tt>" ++ show n ++ "</tt><p>"
