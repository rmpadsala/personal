module ApplicationHelper
  def full_title(page_title)
    base_title = "AlgoFast Sample Braintree payment processing app"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end  

  def current_local_time
		Time.zone.now.strftime('%m/%d/%Y %I:%M:%S %p')
  end	

  # Method to dynamically remove single strategy event fields or 
  # basket fields
  # arguments
  # => name: name of the link
  # => f: form 
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name , 
      "remove_fields(this)")
  end

  # Method to dynamically add single strategy event fields or 
  # basket fields
  # arguments
  # => name: name of the link
  # => f: form 
  # => association: name of the association
  def link_to_add_fields(name, f, association)
    # build an instance of new association object
    new_object = f.object.class.reflect_on_association(association).klass.new
    # create a new fields_for and render partials for each set of fields
    fields = f.fields_for(association, new_object, 
      # child_index creates a new unqiue name while rendering
      :child_index => "new_#{association}") do |builder|
      render("event_fields", :f => builder)
    end
    # add link to function.
    link_to_function(name, 
      "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

end
