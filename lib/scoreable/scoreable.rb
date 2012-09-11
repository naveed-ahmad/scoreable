require 'rails'
require 'scoreable/generator/active_record'
require 'scoreable/receiver/active_record'
require 'scoreable/scoreable'

module Scoreable
  ActiveRecord::Base.class_eval do
    extend Scoreable::Generator::ClassMethods
    extend Scoreable::Receiver::ClassMethods
  end
end
