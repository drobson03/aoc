import Data.Char (digitToInt)

parseInt :: String -> Int
parseInt = read

largestJoltage :: [Int] -> Int
largestJoltage xs =
  let y = maximum . (take ((length xs) - 1)) $ xs
   in parseInt $ (show y ++ show (maximum . (drop 1) . (dropWhile (/= y)) $ xs))

main :: IO ()
main = do
  input <- readFile "inputs/day3.txt"

  print $ sum $ map (largestJoltage . (map digitToInt)) $ words input

  return ()
