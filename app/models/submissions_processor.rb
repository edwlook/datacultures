class Canvas::SubmissionsProcessor

  attr_accessor :request_object, :submission_score

  def initialize(conf)
    @request_object = conf[:request_object]
    @submission_score = PointsConfiguration.where({interaction: 'Submission'}).first.points_associated
    @submission_edit_score = PointsConfiguration.where({interaction: 'SubmissionEdit'}).first.points_associated
  end

  def process(submission_json)
    assignment_id = submission_json['assignment_id'].to_s
    base_params = {
      canvas_updated_at: submission_json['updated_at'],
      body: submission_json['body']
    }
    scoring_record = Activity.where({canvas_scoring_item_id: assignment_id, reason: 'Submission'}).order('updated_at DESC').first
    if scoring_record
      if submission_json['body'] != scoring_record['body']
        Activity.score!(base_params.merge({
          canvas_scoring_item_id: scoring_record.canvas_scoring_item_id,
          reason: 'SubmissionEdit',
          delta: @submission_edit_score
        }))
      end
    else
      Activity.score!(base_params.merge({
        canvas_scoring_item_id: assignment_id,
        reason: 'Submission',
        delta: @submission_score,
        canvas_user_id: submission_json['user_id']
      }))
    end
  end

end
