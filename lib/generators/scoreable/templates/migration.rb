class Create<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table(:<%= Scoreable.table_name %>) do |t|
      # earned <%= Scoreable.score_term %>
      t.decimal :<%= Scoreable.score_term %>
      
      # <%= Scoreable.score_term%> receiver(polymorphic)
      t.integer :<%= Scoreable.score_receiver_name.foreign_key %>
      t.string :<%= Scoreable.score_receiver_name%>_type

      # <%= Scoreable.score_term%> generator(polymorphic)
      t.integer :<%= Scoreable.score_generator_name.foreign_key %>
      t.string :<%= Scoreable.score_generator_name%>_type

      #which action has generated this score
      t.string :action
      
      t.timestamps
    end

    add_index :<%= Scoreable.table_name %>,  [<%= ":#{Scoreable.score_receiver_name.foreign_key}, :#{Scoreable.score_receiver_name}_type" %>], name: '<%= "index_#{Scoreable.table_name}_on_#{Scoreable.score_receiver_name}"%>'
    add_index :<%= Scoreable.table_name %>,  [:<%= ":#{Scoreable.score_generator_name.foreign_key} , :#{Scoreable.score_generator_name}_type"%>], name: '<%= "index_#{Scoreable.table_name}_on_#{Scoreable.score_generator_name}"%>'

    # remove comment if you want to use this index too
    #add_index :<%= Scoreable.table_name %>,  [:<%= "#{Scoreable.score_generator_name}_type" %>, :action], name: '<%= "index_#{Scoreable.table_name}_on_#{Scoreable.score_generator_name}_type_and_action"%>'
  end
end