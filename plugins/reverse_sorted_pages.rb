# inspired by https://github.com/aucor/jekyll-plugins
module Jekyll
  class SortedPagesGenerator < Generator
    safe true
    def generate(site)
      site.config['reverse_sorted_pages'] = site.pages.sort_by { |a| 
        a.data['date'] ? a.data['date'] : site.pages.length.to_s }.reverse
    end
  end
end
