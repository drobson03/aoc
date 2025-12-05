parseInt :: String -> Int
parseInt = read

split :: Char -> String -> [String]
split delim "" = []
split delim str = takeWhile (/= delim) str : (split delim $ dropWhile (== delim) $ dropWhile (/= delim) str)

createRange :: [Int] -> [Int]
createRange [x, y] = [x..y]

isRepeating :: String -> Bool
isRepeating str = let
  halfLength = length str `div` 2
  in take halfLength str == drop halfLength str

main :: IO ()
main = do
  input <- readFile "inputs/day2.txt"

  let productIdRanges = takeWhile (/= '\n') input

  print $ sum $ map parseInt $ filter isRepeating $ map show $ concatMap (createRange . (map parseInt) . (split '-')) $ split ',' $ productIdRanges

  return ()
