module ApplicationHelper
  def profile_img(user)
    return image_tag(user.avatar, alt: user.name, size: "64x64") if user.avatar?

    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name, size: "64x64")
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger",alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |flash_type, message|
      concat(
      content_tag(:div, message, class: "alert alert-dismissable #{bootstrap_class_for(flash_type)} fade in") do
        concat(
        content_tag(:button, class: "close", data: { dismiss: "alert" }) do
          concat content_tag(:span, "&times;".html_safe)
        end
        )
        concat message
      end
      )
    end
  end


end
