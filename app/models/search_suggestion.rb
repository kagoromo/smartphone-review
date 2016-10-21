class SearchSuggestion
  class << self
    def terms_for prefix
      $redis.zrevrange "search-suggestions:#{prefix.downcase}", 0, 4
    end

    def index_review review
      decoded_title = ActionView::Base.full_sanitizer.
        sanitize(HTMLEntities.new.decode review.title).squish
      decoded_content = ActionView::Base.full_sanitizer.
        sanitize(HTMLEntities.new.decode review.content).squish
      index_term decoded_title
      index_term decoded_content
      decoded_title.split(/\W+/).each {|t| index_term t}
      decoded_content.split(/\W+/).each {|t| index_term t}
    end

    def index_reviews reviews
      reviews.each do |review|
        decoded_title = ActionView::Base.full_sanitizer.
          sanitize(HTMLEntities.new.decode review.title).squish
        decoded_content = ActionView::Base.full_sanitizer.
          sanitize(HTMLEntities.new.decode review.content).squish
        index_term decoded_title
        index_term decoded_content
        decoded_title.split(/\W+/).each {|t| index_term t}
        decoded_content.split(/\W+/).each {|t| index_term t}
      end
    end

    def index_term term
      1.upto(term.length - 1) do |n|
        prefix = term[0, n]
        $redis.zincrby "search-suggestions:#{prefix.downcase}", 1, term.downcase
      end
    end
  end
end
