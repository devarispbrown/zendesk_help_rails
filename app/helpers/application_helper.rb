module ApplicationHelper

  def ember_template(name)
    content_tag(:script, render(:partial => "/layouts/#{name}"), :type => 'text/x-handlebars', 'data-template-name' => name)
  end

end
