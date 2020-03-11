class RankingsController < ApplicationController
  def index
      @aggregates = Qfile.joins(:results).select("qfiles.id, qfiles.title, qfiles.results_count, COUNT(distinct results.user_id) AS count_distinct_results_user_id").group("results.qfile_id, qfiles.category, results_count").order("qfiles.id ASC")
  end

  def show
  end

end
