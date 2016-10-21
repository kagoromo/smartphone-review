class SearchSuggestionWorker
  include Sidekiq::Worker
  include Sidekiq::Throttled::Worker

  sidekiq_throttle({
    :concurrency => {:limit => 2}
  })

  INDEX_REVIEW = 1

  def perform action, review_id
    case action
    when INDEX_REVIEW
      index_new_review review_id
    end
  end

  private
  def index_new_review review_id
    review = Review.find_by id: review_id
    SearchSuggestion.index_review review
  end
end
