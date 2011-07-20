# Title: Include Code Tag for Jekyll
# Author: Brandon Mathis http://brandonmathis.com
# Description: Import files on your filesystem into any blog post as embedded code snippets with syntax highlighting and a download link.
# Configuration: You can set default import path in _config.yml (defaults to code_dir: downloads/code)
#
# Syntax {% include_code path/to/file %}
#
# Example:
# {% include_code javascripts/test.js %}
#
# This will import test.js from source/downloads/code/javascripts/test.js
# and output the contents in a syntax highlighted code block inside a figure,
# with a figcaption listing the file name and download link
#

require 'pathname'

module Jekyll

  class IncludeCodeTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      @title = nil
      @file = nil
      if markup.strip =~ /(.*)?(\s+|^)(\/*\S+)/i
        @title = $1 || nil
        @file = $3
      end
      super
    end

    def render(context)
      code_dir = (context.registers[:site].config['code_dir'] || 'downloads/code')
      code_path = (Pathname.new(context.registers[:site].source) + code_dir).expand_path
      file = code_path + @file

      if File.symlink?(code_path)
        return "Code directory '#{code_path}' cannot be a symlink"
      end

      unless file.file?
        return "File #{file} could not be found"
      end

      Dir.chdir(code_path) do
        code = file.read
        file_type = file.extname
        title = @title ? "#{@title} (#{file.basename})" : file.basename
        url = "#{context.registers[:site].config['url']}/#{code_dir}/#{@file}"
        source = "<div><figure role=code><figcaption><span>#{title}</span> <a href='#{url}'>download</a></figcaption>\n"
        source += "{% highlight #{file_type} %}\n" + code + "\n{% endhighlight %}</figure></div>"
        partial = Liquid::Template.parse(source)
        context.stack do
          partial.render(context)
        end
      end
    end
  end

end

Liquid::Template.register_tag('include_code', Jekyll::IncludeCodeTag)