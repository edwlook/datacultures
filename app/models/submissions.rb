class Submissions

  require 'json'

  def initialize(options={})
    @course_id = options[:course_id]
  end

  def get_submissions_as_json
    {
      :course_id => @course_id,
      :submissions => get_submissions
    }
  end

  def get_submissions
    request_uri = '/api/v1/courses/1/students/submissions?student_ids=all&grouped=true'
    request_obj = Canvas::ApiRequest.new({
      base_url: Rails.application.secrets.requests['base_url'],
      api_key: Rails.application.secrets.requests['api_keys']['submissions_api']
    })
    response = request_obj.request.get(request_uri).body
    response[0]['submissions']
  end

end
