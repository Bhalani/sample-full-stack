class Report
  def this_week_records_count
    this_week_records.count
  end

  def last_week_records_count
    last_week_records.count
  end

  def average_calories_per_user
    total_calories = this_week_records.group("user_id").select("SUM(calories) as total_calories")
    total_calories.map(&:total_calories).sum / User.count
  end

  private

  def this_week_records
    last_day = DateTime.now
    first_day = last_day - 7.days

    UserCalory.where("consume_at >= ? and consume_at <= ?", first_day, last_day)
  end

  def last_week_records
    last_day = DateTime.now - 8.days
    first_day = last_day - 7.days

    UserCalory.where("consume_at >= ? and consume_at <= ?", first_day, last_day)
  end
end
