import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)

parseRotations :: [Char] -> Maybe Int
parseRotations ('L' : xs) = negate <$> readMaybe xs :: Maybe Int
parseRotations ('R' : xs) = readMaybe xs :: Maybe Int

doRotations :: Int -> Int -> [Int] -> Int
doRotations pos zeroes [] = zeroes
doRotations 0 zeroes (rotation : rotations) = doRotations (mod rotation 100) (zeroes + 1) rotations
doRotations pos zeroes (rotation : rotations) = doRotations (mod (pos + rotation) 100) zeroes rotations

toSingleRotations :: Int -> [Int]
toSingleRotations x
  | x >= 0 = take x $ repeat 1
  | x < 0 = take (negate x) $ repeat (-1)

main :: IO ()
main = do
  input <- readFile "inputs/day1.txt"

  let rotations = map (fromMaybe 0 . parseRotations) $ lines $ input

  print $ doRotations 50 0 $ rotations

  print $ doRotations 50 0 $ concatMap toSingleRotations rotations

  return ()
