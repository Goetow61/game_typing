class RankingsController < ApplicationController
  def index
    @aggregates = Qfile.joins(:results).select("qfiles.id, qfiles.title, qfiles.results_count, COUNT(distinct results.user_id) AS count_distinct_results_user_id").group("results.qfile_id, qfiles.category, results_count").order("qfiles.id ASC")
  end

  def show
    @results = Result.order("results.speed DESC, results.created_at ASC").where(qfile_id: params[:id]).includes(:user)
  end

end
