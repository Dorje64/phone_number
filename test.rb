require 'pry'
$number_to_letter = {2=> %w(a b c), 3=> %w(d e f), 4=> %w(g h i), 5=> %w(j k l), 6=> %w(m n o), 7=> %w(p q r s), 8=> %w(t u v), 9=> %w(w x y z)}
$sub_dicts={}
$reverse_sub_dicts={}
$pre_words = { 2 =>  [], 3 =>  [], 4 => [], 5 => [], 6 => [], 7 => [] , 8 => [], 9 => [], 10 => [] }
$post_words = { 2 =>  [], 3 =>  [], 4 => [], 5 => [], 6 => [], 7 => [] , 8 => [], 9=> [], 10 => [] }

#chunck the dictionary
def chunck_the_dictionary()
  File.open('dictionary.txt', 'r').each do |line|
    word = line.strip.downcase
    last_index = word.size - 1
    $sub_dicts[word[0]].nil? && $sub_dicts[line[0].downcase] = []
    $sub_dicts[word[0]] << word
    $reverse_sub_dicts[word[last_index]].nil? && $reverse_sub_dicts[line[last_index].downcase] = []
    $reverse_sub_dicts[word[last_index]] << word
  end
end

def does_start_with?(word)
  # binding.pry
  $sub_dicts[word[0]].include?(word) && $pre_words[word.length] << word
  $sub_dicts[word[0]].each do |line|
    if line.start_with?(word)
      return true
    end
  end
  return false
end

def does_end_with?(word)
  $reverse_sub_dicts[word[0]].include?(word.reverse) && $post_words[word.length] << word.reverse
  $reverse_sub_dicts[word[0]].reverse.each do |line|
    # binding.pry
    if line.end_with?(word.reverse)
      return true
    end
  end
  return false
end

def map_number_to_word(number)
  number_to_letter = {2=> %w(a b c), 3=> %w(d e f), 4=> %w(g h i), 5=> %w(j k l), 6=> %w(m n o), 7=> %w(p q r s), 8=> %w(t u v), 9=> %w(w x y z)}
  words = []
  number.each do |num|
    if words.empty?
      words = number_to_letter[num]
    else
      current_loop_words = []
      combinations = words.product(number_to_letter[num])
      combinations.each do |comb|
        word = comb.join
        if does_start_with?(word)
          current_loop_words << word
        end
      end
      words = current_loop_words;
    end
  end
end

def reverse_map(number)
  number_to_letter = {2=> %w(a b c), 3=> %w(d e f), 4=> %w(g h i), 5=> %w(j k l), 6=> %w(m n o), 7=> %w(p q r s), 8=> %w(t u v), 9=> %w(w x y z)}
  words = []
  number.each do |num|
    # binding.pry
    if words.empty?
      words = number_to_letter[num]
    else
      current_loop_words = []
      combinations = words.product(number_to_letter[num])
      combinations.each do |comb|
        word = comb.join
        if does_end_with?(word)
          current_loop_words << word
        end
      end
      words = current_loop_words;
    end
  end
end

chunck_the_dictionary();
number = '6686787825'.chars.map(&:to_i)
# number = '2282668687'.chars.map(&:to_i)
map_number_to_word(number)
reverse_map(number.reverse)

matched = $pre_words[10]
$pre_words[2].any? && $post_words[8].any? && matched << $pre_words[2].product($post_words[8])
$pre_words[3].any? && $post_words[7].any? && matched << $pre_words[3].product($post_words[7])
$pre_words[4].any? && $post_words[6].any? && matched << $pre_words[4].product($post_words[6])
$pre_words[5].any? && $post_words[5].any? && matched << $pre_words[5].product($post_words[5])
$pre_words[6].any? && $post_words[4].any? && matched << $pre_words[6].product($post_words[4])
$pre_words[7].any? && $post_words[3].any? && matched << $pre_words[7].product($post_words[3])
$pre_words[8].any? && $post_words[2].any? && matched << $pre_words[8].product($post_words[2])
print matched

# number = '2282668687'.chars.map(&:to_i)
# map_number_to_word(number)
# reverse_map(number.reverse)
