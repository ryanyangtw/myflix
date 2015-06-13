module ApplicationHelper
  
  def options_for_video_reviews(selected = nil)
    options_for_select((1..5).map {|num| [pluralize(num, "Star"), num]}, selected)
  end

  def gravatar_for(email)
    return "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=40"
  end

end
