module Scoreable
  module Receiver
    module ClassMethods
      define_method "receive_#{Scoreable.score_term}" do
        has_many  "#{Scoreable.table_name}".to_sym, as: Scoreable.score_receiver_name
        
        include Scoreable::Receiver::InstanceMethods
      end
    end

    module InstanceMethods
      define_method "total_#{Scoreable.score_term}" do
        eval(Scoreable.table_name).sum Scoreable.score_term
      end
    end
  end
end


