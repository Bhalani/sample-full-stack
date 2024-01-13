class Api::Admin::DashboardController < Api::Admin::AdminController
  def index
    report = Report.new

    render json: { metrics: {
      this_week_records: report.this_week_records_count,
      last_week_records: report.last_week_records_count,
      average_calories_per_user: report.average_calories_per_user
    }}
  end
end
