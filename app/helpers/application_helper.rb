module ApplicationHelper
  def render_markdown(text)
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(text.to_s)
  end
end
