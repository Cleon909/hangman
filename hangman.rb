# code for hangman game 

$word = ""
$worddisplay = ""
$guess = ""
$strikes = 8
$guessed_letters = []
$game_over = 0

$hangmanpics = ['''
  +---+
      |
      |
      |
      |
      |
      |
=========''', '''
  +---+
  |   |
      |
      |
      |
      |
      |
=========''', '''
  +---+
  |   |
  |   |
      |
      |
      |
      |
=========''', '''
  +---+
  |   |
  |   |
  O   |
      |
      |
      |
=========''', '''
  +---+
  |   |
  |   |
  O   |
  |   |
      |
      |
=========''', '''
  +---+
  |   |
  |   |
  O   |
 /|   |
      |
      |
=========''', '''
  +---+
  |   |
  |   |
  O   |
 /|\  |
      |
      |
=========''', '''
  +---+
  |   |
  |   |
  O   |
 /|\  |
 /    |
      |
=========''', '''
  +---+
  |   |
  |   |
  O   |
 /|\  |
 / \  |
      |
=========''']


def pick_word
  wordlist = File.read("5desk.txt").split(/\W+/)
  $word = wordlist.sample
end


def create_template
  $word.length.times {$worddisplay << "-" }
end

def get_input
  $guess = ""
  until ($guess.match?(/[[:alpha:]]/) && $guess.length == 1) || $guess == "1"
   puts "input letter or input 1 to save game"
    $guess = gets.chomp.downcase
  end
end

def check
  if $guess == '1'
    save_game()
    puts "Game saved, goodbye"
    $game_over = 1
  else
    let = (0...$word.length).find_all { |i| $word[i,1] == $guess}
    if let.empty?
      $strikes -= 1
      puts "No letters found, you have #{$strikes} lives left"
    else
      let.each { |l| $worddisplay[l] = $guess }
    end
  end
  $guessed_letters << $guess
end

def turn
  puts $hangmanpics[8-$strikes]
  puts "word to guess is #{$worddisplay}"
  puts "you have #{$strikes} left"
  puts "you have already used #{$guessed_letters}"
  puts "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  get_input()
  check()
  check_game_state()
end

def check_game_state
  if $strikes == 0
    puts $hangmanpics[-1]
    puts "you have been hanged!"
    puts "The word was #{$word}"
    $game_over = 1
  end
  if $worddisplay.include?("-") == false
    puts "You have guessed the word!"
    puts "it was #{$word}"
    $game_over = 1
  end
end

def load_choice
  choice = 0
  puts "press 1 to load game and 2 to play new game"
  choice = gets.chomp
  if choice == '1'
    load_game()
  elsif choice == '2'
    game()
  else
    load_choice()
  end
end

def load_game
  load_file = File.read("hangman_save.txt")
  load_file = load_file.split("\n")
  $word = load_file[0]
  $worddisplay = load_file[1]
  $strikes = load_file[2].to_i
  $guessed_letters = load_file[3].split("")
  until $game_over == 1
    turn()
  end
end

def save_game
  save_file = File.open("hangman_save.txt", "w") { |file|  file.puts [$word, $worddisplay, $strikes, $guessed_letters.join]}
end


def game
  pick_word()
  create_template()
  until $game_over == 1
    turn()
  end
end

load_choice()


