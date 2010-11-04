module ApplicationHelper
  def title_content
    base_title = "YEAH Project" 
    return "#{base_title} | #{@title}" unless @title.nil?
    base_title
  end
  
  def logo
    image_tag 'logo.png', :alt => "YEAH project", :class => 'round'
  end
end
