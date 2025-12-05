parseInt :: String -> Int
parseInt = read

split :: Char -> String -> [String]
split delim "" = []
split delim str = takeWhile (/= delim) str : (split delim $ dropWhile (== delim) $ dropWhile (/= delim) str)

createRange :: [Int] -> [Int]
createRange [x, y] = [x..y]

isRepeatingPart1 :: String -> Bool
isRepeatingPart1 str = let
  halfLength = length str `div` 2
  in take halfLength str == drop halfLength str

isRepeatingPart2 :: Int -> String -> Bool
isRepeatingPart2 0 _ = False
isRepeatingPart2 x str = let
  parts = length str `div` x
  sub = take x str
  in (concat (take parts (repeat sub)) == str) || (isRepeatingPart2 (x - 1) str)

main :: IO ()
main = do
  input <- readFile "inputs/day2.txt"

  let productIds = map show $ concatMap (createRange . (map parseInt) . (split '-')) $ split ',' $ takeWhile (/= '\n') input

  print $ sum $ map parseInt $ filter isRepeatingPart1 productIds
  print $ sum $ map parseInt $ filter (\x -> isRepeatingPart2 (length x `div` 2) x) productIds

  return ()
