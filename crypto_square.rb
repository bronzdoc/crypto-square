class Crypto
  attr_reader :size

  def initialize(text)
    @text = text
    sqrt = Math.sqrt(normalize_plaintext.size).to_i
    @size =
      if sqrt * sqrt == normalize_plaintext.size
        sqrt
      else
        sqrt + 1
      end
  end

  def normalize_plaintext
    text = @text.dup
    text.gsub(/\W/, "").gsub(" ", "").downcase
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{@size}}/)
  end

  def ciphertext
    cypher.join
  end

  def normalize_ciphertext
    cypher.join(" ")
  end

  private
  def cypher
    words = []

    plaintext_segments.each do |word|
      word.chars.each_with_index do |char, k|
        if words[k].nil?
          words[k] = char
        else
          words[k] << char
        end
      end
    end
    words
  end
end
