import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)

parseRotations :: [Char] -> Maybe Int
parseRotations ('L' : xs) = negate <$> readMaybe xs :: Maybe Int
parseRotations ('R' : xs) = readMaybe xs :: Maybe Int

doRotationsPart1 :: Int -> Int -> [Int] -> Int
doRotationsPart1 pos zeroes [] = zeroes
doRotationsPart1 0 zeroes (rotation : rotations) = doRotationsPart1 (mod rotation 100) (zeroes + 1) rotations
doRotationsPart1 pos zeroes (rotation : rotations) = doRotationsPart1 (mod (pos + rotation) 100) zeroes rotations

parseRotationsPart2 :: [Char] -> [Int]
parseRotationsPart2 ('L' : xs) = let
    x = readMaybe xs :: Maybe Int
  in take (fromMaybe 0 x) $ repeat (-1)
parseRotationsPart2 ('R' : xs) = let
    x = readMaybe xs :: Maybe Int
  in take (fromMaybe 0 x) $ repeat 1

doRotationsPart2 :: Int -> Int -> [Int] -> Int
doRotationsPart2 pos zeroes [] = zeroes
doRotationsPart2 0 zeroes (rotation : rotations) = doRotationsPart2 (mod rotation 100) (zeroes + 1) rotations
doRotationsPart2 pos zeroes (rotation : rotations) = doRotationsPart2 (mod (pos + rotation) 100) zeroes rotations

main :: IO ()
main = do
  input <- readFile "inputs/day1.txt"

  let rotations = map (fromMaybe 0 . parseRotations) $ lines $ input

  print $ doRotationsPart1 50 0 $ rotations

  print $ doRotationsPart2 50 0 $ concat $ map parseRotationsPart2 $ lines $ input

  -- L: x -> 0
  -- R: x -> \infty
  -- 0 \leq 0 \leq 99
  -- want: number of times x changes to 0 after rotation
  return ()
