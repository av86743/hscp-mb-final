
import System.Process
import System.Exit

main :: IO ()
-- main = putStrLn "Test suite not yet implemented"

main = do ExitSuccess <- system "sh -c 'cd test && ./run.sh'" ; return ()

