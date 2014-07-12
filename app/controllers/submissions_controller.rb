class SubmissionsController < ApplicationController

  def get_submissions
    render :json => Submissions.new(:course_id => params[:course_id]).get_submissions_as_json
  end

end
