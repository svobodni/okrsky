require 'bootstrap_helpers/bootstrap_flash_helper'
require 'bootstrap_helpers/navbar_helper'
require 'bootstrap_helpers/navbar_helper_fix'

ActionView::Base.send :include, BootstrapFlashHelper
ActionView::Base.send :include, NavbarHelper
