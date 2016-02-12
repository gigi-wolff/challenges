require "pry"

class InvalidCodonError < StandardError
end
#
=begin
module Translation
  CODON_PROTEIN = {
    'AUG' => 'Methionine',    'UUU' => 'Phenylalanine',
    'UUC' => 'Phenylalanine', 'UUA' => 'Leucine',
    'UUG' => 'Leucine',       'UCU' => 'Serine',
    'UCC' => 'Serine',        'UCA' => 'Serine',
    'UCG' => 'Serine',        'UAU' => 'Tyrosine',
    'UAC' => 'Tyrosine',      'UGU' => 'Cystine',
    'UGC' => 'Cystine',       'UGG' => 'Tryptophan',
    'UAA' => 'STOP',          'UAG' => 'STOP',
    'UGA' => 'STOP'
  }

  def self.of_codon(codon)
    CODON_PROTEIN.fetch(codon) { fail InvalidCodonError }
  end

  def self.of_rna(strand)
    strand.scan(/.../).take_while { |codon| of_codon(codon) != 'STOP' }
                      .map { |codon| of_codon(codon) }
  end
end
=end

module Translation

  RNA_HASH = {"AUG" => "Methionine", "UUC" => "Phenylalanine", "UUU" => "Phenylalanine",
  "UUG" => "Leucine", "UUA" => "Leucine", "UCA" => "Serine", "UCU" => "Serine", "UCC" => "Serine", "UCG" => "Serine",
  "UAC" => "Tyrosine", "UAU" => "Tyrosine", "UGC" => "Cysteine", "UGU" => "Cysteine",
  "UGG" => "Tryptophan", "UAA" => "STOP", "UAG" => "STOP", "UGA" => "STOP"}


  def of_codon(codon)
    RNA_HASH[codon]
  end

  def stop?(codon)
    if (codon == 'UAA' || codon == 'UAG' || codon == 'UGA')
      true
    else
      false
    end
  end

  def of_rna(strand)
    #strand.scan(/.../) {|c| proteins = proteins + of_codon(c) + " " unless stop?(c)}
    proteins = strand.scan(/.../).take_while {|c| !stop?(c)}. map {|a| of_codon(a)}
    p proteins
  end
end

include Translation
#strand = "AUGUUUUCUUAAAUG"
strand = "AUGUUUUGG"
strand = 'AUGUUUUAA'
of_rna(strand)

=begin
module Codon_To_Protein

  RNA_HASH = {"AUG" => "Methionine", "UUC" => "Phenylalanine", "UUU" => "Phenylalanine",
  "UUG" => "Leucine", "UUA" => "Leucine", "UCA" => "Serine", "UCU" => "Serine", "UCC" => "Serine", "UCG" => "Serine",
  "UAC" => "Tyrosine", "UAU" => "Tyrosine", "UGC" => "Cysteine", "UGU" => "Cysteine",
  "UGG" => "Tryptophan", "UAA" => "STOP", "UAG" => "STOP", "UGA" => "STOP"}

end

class Codon
  include Codon_To_Protein

  attr_accessor :name

  def initialize(input_name=nil)
    self.name = input_name
  end

  def to_protein
    p = RNA_HASH[name]
  end

  def stop?
    if (name == 'UAA' || name == 'UAG' || name == 'UGA')
      true
    else
      false
    end
  end

  def to_s
    "#{name}"
  end
end

class RNA 
  attr_accessor :sequence, :codons, :proteins

  def initialize(input_rna='')
    @codons = []
    @proteins = []
    @sequence = input_rna
  end

  def size
    sequence.size
  end

  def codon_count
    codons.size
  end

  def to_s
    s = "rna sequence: #{sequence}\n" + "codons: " 
    codons.each {|c| s << c.to_s + "  "}
    s += "\n"
    proteins.each {|p| s << p + "  "}  
    return s    
  end
end


#rna = gets.chomp
input_rna = "AUGUUUUCUUAAAUG"

codons = []
rna = RNA.new(input_rna)

i = 0
offset = 3
while i <= rna.size-offset
  codon = Codon.new(rna.sequence.slice(i...i+offset))
  rna.proteins << codon.to_protein unless codon.stop? 
  rna.codons << codon
  i += offset
end


puts rna
=end
