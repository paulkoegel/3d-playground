module ApplicationHelper
  
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block)}
    uri = "#{Rails.application.config.faye_url}/irmingard-faye"
    HTTParty.post uri, :body => {:message => message.to_json}
  end

end
