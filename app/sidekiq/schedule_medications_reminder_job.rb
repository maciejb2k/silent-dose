class ScheduleMedicationsReminderJob
  include Sidekiq::Job

  def perform
    ReminderTime.find_each do |reminder_time|
      now = Time.current
      hour = reminder_time.time.hour
      minute = reminder_time.time.min

      if now.hour == hour && now.min == minute
        MedicationsReminderJob.perform_async(reminder_time.user_id, reminder_time.id)
      end
    end
  end
end
