require 'net/http'
require 'json'

require_relative './request'

DHH_SCORES = {
  issues_event: 7,
  issue_comment_event: 6,
  push_event: 5,
  pull_request_review_comment_event: 4,
  watch_event: 3,
  create_event: 2,
  any_other_event: 1
}.freeze

URL = 'https://api.github.com/users/dhh/events/public'.freeze

# Calculates and displays dhh total score
class DhhScoreChallenge
  def calculate_and_display_dhh_score
    response = make_api_request_and_fetch_data
    parsed_response = JSON.parse(response.body)
    commit_types = parsed_response.map { |res| res['type'] }
    total_score = calculate_total_score(commit_types)
    puts "DHH's github score is #{total_score}"
  end

  def calculate_total_score(commit_types)
    total_score = 0
    commit_types.each do |commit_type|
      case commit_type
      when 'IssuesEvent'
        total_score += DHH_SCORES[:issues_event]
      when 'IssueCommentEvent'
        total_score += DHH_SCORES[:issue_comment_event]
      when 'PushEvent'
        total_score += DHH_SCORES[:push_event]
      when 'PullRequestReviewCommentEvent'
        total_score += DHH_SCORES[:pull_request_review_comment_event]
      when 'WatchEvent'
        total_score += DHH_SCORES[:watch_event]
      when 'CreateEvent'
        total_score += DHH_SCORES[:create_event]
      else
        total_score += DHH_SCORES[:any_other_event]
      end
    end
    total_score
  end

  def make_api_request_and_fetch_data
    Request.new.fetch_api_response(URL)
  end
end

dhh = DhhScoreChallenge.new
dhh.calculate_and_display_dhh_score
