module MarkdownHelper
  def markdown(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
        :autolink => true, :space_after_headers => true)
    md.render(text)
  end
end