# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Remove once 2.3.6 comes out!
  # https://rails.lighthouseapp.com/projects/8994/tickets/1311-add-content_forname-helper
  def content_for?(name)
    instance_variable_get("@content_for_#{name}").present?
  end

  def page_title
    "herokutter"
  end
end
