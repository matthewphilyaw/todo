import System.Environment
import System.IO
import System.Directory
import Data.List

dispatch :: [(String, [String] -> IO ())]
dispatch = [ ("add", add)
           , ("view", view)
           , ("remove", remove)
           , ("bump", bump)
           ]

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoList = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [1..] todoList
    putStr $ unlines numberedTasks 

remove :: [String] -> IO ()
remove = alterLine (\ls n -> delete (ls !! (n -1)) ls)

bump :: [String] -> IO ()
bump = alterLine (\ls n -> let item = ls !! (n - 1) in item : delete item ls)

alterLine :: ([String] -> Int -> [String]) -> [String] -> IO ()
alterLine f [fileName, numStr] = do
    handle <- openFile "todo.txt" ReadMode
    (tmpName, tmpHandle) <- openTempFile "." "temp"
    contents <- hGetContents handle
    
    let number = read numStr
        todoList = lines contents
        newTodoItems = f todoList number

    hPutStr tmpHandle $ unlines newTodoItems
    hClose handle
    hClose tmpHandle
    removeFile fileName 
    renameFile tmpName fileName 

main = do
    (command:args) <- getArgs
    let (Just action) = lookup command dispatch
    action args
