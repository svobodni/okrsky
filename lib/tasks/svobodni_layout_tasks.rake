# encoding: utf-8
require 'svobodni_layout'

namespace :svobodni_layout do
  desc "Fetch and install centralized application layout"
  task :install do
    template = SvobodniLayout::Processor.new
    template.fetch
    template.head = '
     <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
     <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
     <%= csrf_meta_tags %>
    '
    template.title = '<%= @page_title || "Svobodní" %>'
    template.breadcrumb = '<%= breadcrumbs separator: " / " %>'
    template.store
  end
end