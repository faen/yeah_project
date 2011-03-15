module ApplicationHelper
  def title_content
    base_title = "YEAH Project" 
    return "#{base_title} | #{@title}" unless @title.nil?
    base_title
  end
  
  def logo
    image_tag 'logo.png', :alt => "YEAH project", :class => 'round'
  end
  
  def resource_browser target_resource
    rb = "<p id='resource_browser'>You are here: "
    holders = target_resource.holder_chain 
    last_index = holders.count - 1
    holders.each_with_index do |h, index| 
      parent_holder = h.holder
      parent = parent_holder ? parent_holder : current_user
      rb += link_to h.name, polymorphic_path([parent, h])
      rb += " / " if index < last_index
    end
    rb += "</p>"
    rb.html_safe
  end
  
  def parent_path current_resource
    parent = current_resource.holder
    polymorphic_path([parent.holder, parent])
  end
  
  def parent_link current_resource
    parent = current_resource.holder
    ancestor = parent.holder ? parent.holder : current_user
    path = polymorphic_path([ancestor, parent])
    label = "back to #{parent.class.name}"
    link_to label, path
  end
  
  def crud_links links
    cl = "<div class='crud_links'>"
    links.each do |link|
      path = link[:path] 
      index = link[:index]
      if(index == 'delete')
        cl += link_to index, path, :class => index, :title => index, :method => :delete, :confirm => "Are you sure?"
      else
        cl +=  link_to index, path, :class => index, :title => index
      end
    end
    cl += "</div>"
    cl.html_safe
  end
end
