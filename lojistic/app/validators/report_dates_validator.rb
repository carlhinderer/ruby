class ReportDatesValidator < ActiveModel::Validator
  def validate(record)
    if record[:start_date] and record[:end_date]
      unless record[:start_date] < record[:end_date]
        record.errors[:start_date] << "must be before end date."
      end
    end
  end
end