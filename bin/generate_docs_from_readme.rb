require 'redcarpet'
require 'pry'

@data = File.read("./README.md")

rndr = Redcarpet::Render::HTML.new(prettify: true)
markdown = Redcarpet::Markdown.new(rndr,
                                   autolink: false,
                                   space_after_headers: true,
                                   prettify: true,
                                   no_intra_emphasis: true,
                                   fenced_code_blocks: true,
                                   disable_indented_code_blocks: false,
                                   strikethrough: true,
                                   space_after_headers: true,
                                   superscript: true,
                                   underline: true,
                                   highlight: true,
                                   tables: true,
                                   quote: false,
                                   footnotes: true)

File.open('./docs/index.html', 'w') do |f|
  f.write('<html><head><title>Moodle Automation Suite Documentation</title><link href="prettify.css" type="text/css" rel="stylesheet" /><script type="text/javascript" src="prettify.js"></script><link href="styles.css" rel="stylesheet"></head><body onload="prettyPrint()"><article class="markdown-body entry-content">')
  f.write(markdown.render(@data))
  f.write('</article></script></body>
</html>')
end

