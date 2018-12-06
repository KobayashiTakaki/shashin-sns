module ApplicationHelper
  #ページのタイトルを返す
  def full_title(title = '')
    base_title = 'Shasin SNS'
    title.blank? ? base_title : "#{title} | #{base_title}"
  end
end
