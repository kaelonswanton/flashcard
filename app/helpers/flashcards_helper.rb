module FlashcardsHelper
  def difficulty_to_word(difficulty)
    case difficulty
      when 1.0..1.67
        "Easy"
      when 1.68..2.34
        "Medium"
      when 2.35..3.0
        "Hard"
      else
        "New"
    end
  end
end
