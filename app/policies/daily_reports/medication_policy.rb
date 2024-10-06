class DailyReports::MedicationPolicy < ApplicationPolicy
  def sort?
    owner_or_admin?
  end
end
