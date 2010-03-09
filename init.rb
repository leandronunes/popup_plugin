# Include hook code here

require 'popup_plugin'

class ActionController::Base
  def self.uses_popup_plugin
    helper PopupPlugin::Helper
  end
end
 
