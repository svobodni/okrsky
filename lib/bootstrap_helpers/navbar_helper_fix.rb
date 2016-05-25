module NavbarHelper

private
  def is_active?(path, options)
    "active" if current_page?(path)
  end

end