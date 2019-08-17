defmodule Mastermind do
    def main() do
    IO.puts("Welcome commander Patel\nThe terrorists have planted a bomb in our embassy\nYou have to crack the secret code to defuse the bomb\ntoo many wrong tries will blow it so be carefull")
        generate_pattern(4)
        |> guess(10)
    end

    def guess(target_pattern, chances) when chances == 0  do
        IO.puts("Game over the pattern was #{target_pattern}")
    end

    def guess(target_pattern, chances) do
        pattern = IO.gets("You have #{chances} chances left to guess the pattern\n") |> String.trim |> String.to_charlist
        case check_pattern(target_pattern,pattern) do
            {count , 0} when length(target_pattern) == count -> IO.puts("You guessed it right\n")
            {pattern_matched , color_matched} -> IO.puts("#{pattern_matched} : correct positon correct color\n#{color_matched} : worng position correct color")
                                                guess(target_pattern, chances - 1)
            end
    end

    def check_pattern(target_pattern, pattern) do

        pattern_matched = Enum.zip(target_pattern , pattern) |> Enum.filter( fn({a, b}) -> a==b end) |> length
        color_not_matched = pattern -- target_pattern |> length
        color_matched = length(pattern) - color_not_matched - pattern_matched
        {pattern_matched , color_matched }

    end
    def generate_pattern(count) do
        seed = Enum.take_random(count..100, count)
        Enum.map seed, fn(number) -> rem(number,count) + 97 end
    end
end