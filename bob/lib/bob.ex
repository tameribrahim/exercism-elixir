defmodule Bob do
  def hey(input) do
    input = String.trim(input)
    cond do
      silence?(input) -> "Fine. Be that way!"
      yell_question?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      yell?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp yell_question?(input), do: Regex.match?(~r/^[^a-z]*[A-Z]+(\?){1}$/, input)
  defp question?(input), do: String.ends_with?(input, "?")
  defp yell?(input), do: Regex.match?(~r/\p{L}+/, input) && input == String.upcase(input)
  defp silence?(input), do: String.length(String.trim(input)) == 0
end
