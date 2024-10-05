class DailyReports::MedicationPolicy < ApplicationPolicy
  def sort?
    owner?
  end
end
