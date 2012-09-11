module Scoreable
  # name of "score"
  mattr_accessor :score_term
  @@score_term = 'score'
  
  def score_term=(term)
    @@score_term = term.to_s.downcase
  end

  class << self
    def config
      yield self
    end

    def table_name
      score_term.tableize
    end

    def model_name
      score_term.camelize
    end

    def score_receiver_name
      "#{score_term}_receiver"
    end

    def score_generator_name
      "#{score_term}_generator"
    end
  end
end
