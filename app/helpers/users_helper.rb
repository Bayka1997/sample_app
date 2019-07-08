module UsersHelper
  def gravatar_for user, options = {size: Settings.sizeImageGravata}
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = Settings.urlGravata + "#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def current_user_build
    current_user.active_relationships.build
  end

  def current_user_find id
    current_user.active_relationships.find_by(followed_id: id)
  end
end
