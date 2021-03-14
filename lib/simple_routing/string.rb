class String
  # 16進数を数値に変換する
  # hex_to_i("\xFF\x2") -> 767
  def to_i_from_hex
    bytes.each.with_index.inject(0) do |sum, (v, index)|
      sum += v << (8 * index)
    end
  end
end
