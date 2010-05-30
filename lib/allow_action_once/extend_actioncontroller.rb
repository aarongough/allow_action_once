module ActionControllerExtension
  def self.included(base)  
    base.send :extend, ClassMethods 
  end  
  
  module ClassMethods 
    def allow_action_once(*args)
      before_filter :allow_action_once_filter, args
      send :include, InstanceMethods
    end
  end  
  
  module InstanceMethods
    def allow_action_once_filter
      action_identifier = "/#{controller_name}/#{action_name}/#{params[:id]}"
      if( cookies[action_identifier].nil? && !cookies[:allow_once_cookies_enabled].nil? )
        cookies[action_identifier] = true
      else
        head :status => :bad_request and return
      end
    end
  end 
end

ActionController::Base.send(:include, ActionControllerExtension)

ActionController::Base.send(:append_after_filter, Proc.new do |controller|
  cookies = controller.send(:cookies)
  cookies[:allow_once_cookies_enabled] = true
end)