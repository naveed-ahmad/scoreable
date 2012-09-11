class <%= Scoreable.model_name%> < ActiveRecord::Base
  belongs_to :<%= Scoreable.score_receiver_name%>, polymorphic: true
  belongs_to :<%= Scoreable.score_generator_name%>, polymorphic: true

end