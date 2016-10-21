namespace :search_suggestions do
  desc "Generate search suggestions from reviews"
  task index: :environment do
    SearchSuggestion.index_reviews Review.all
  end
end
