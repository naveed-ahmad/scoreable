module Scoreable
  module Generator
    module GeneratedMethods;  end

    module ClassMethods
      mattr_accessor :score_receiver
      alias_method "#{Scoreable.score_term}_receiver", :score_receiver
      
      ## Scoreable.score_term = 'score'
      ## use to configure score generation scheme
      #  Example:
      ##   give 5 points to user
      ##   generate_score  create: {score: 5, for: :user}
      ##   generate_score  create: 5 (need to set global score_reciever for this call using score_receiver= :receiver_object, :receiver_object could be a method that will return receiver
      ##
      ##   give 5 point to "user" on "create" and call "report_point" as callback
      ##   generate_score create: { :score: 5, for: :user, callback: :report_score}
      ##
      ##    You can configure score for multiple method in single call
      ##    generate_score update: 4, create: 5, upvote: {score: 5, for: :upvoter}
      ##
      def generate_score(args)
        include Scoreable::Generator::InstanceMethods
        
        args.keys.each do |action|
          score_config = args[action]

          if score_config.is_a? Hash
            score = score_config[Scoreable.score_term.to_sym]
            callback_method = score_config[:callback]
            receivers = score_config[:for]
          else
            callback_method = nil
            receivers = [score_receiver]
            score = score_config
          end
          actions = action.is_a?(Array) ? action : [action.to_s]

          actions.each do |action|
            action= action.to_s
            method_without_score_feature = action+"_without_#{Scoreable.score_term}"
            method_with_score_feature = action+"_with_#{Scoreable.score_term}"

            Scoreable::Generator::GeneratedMethods.class_eval do
              define_method method_with_score_feature.to_sym do
                send method_without_score_feature
                receivers.each do |receiver|
                  score_obj= log_score score,action, receiver

                  send callback_method,score_obj if callback_method
                end
                
                
              end
            end

            include Scoreable::Generator::GeneratedMethods
            alias_method_chain action, Scoreable.score_term
          end
        end
      end
      alias_method "generate_#{Scoreable.score_term}", :generate_score unless respond_to? "generate_#{Scoreable.score_term}"
    end

    module InstanceMethods
      
      def itself
        self
      end

      def  log_score(score,action,receiver)
        receiver = self.send receiver if [String,Symbol].include? receiver.class
        receiver.send(Scoreable.table_name).create! action: action, :"#{Scoreable.score_term}" => score, :"#{Scoreable.score_term}_generator" => self
      end
      alias_method "log_#{Scoreable.score_term}_receiver", :log_score
    end
  end
end
