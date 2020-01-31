require 'redmine'
class DefaultDueApplicationHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = {})
    return javascript_include_tag('defaultdue.js', :plugin => 'redmine_default_due')
  end
end
