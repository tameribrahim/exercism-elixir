defmodule RnaTranscription do

  @rna_dictionary  %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
      |> Enum.map(&(@rna_dictionary[&1]))

  end
end
