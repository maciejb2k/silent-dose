ActiveAdmin.register DailyReport, as: "Calendar" do
  menu parent: "Daily Reports", label: "Calendar", priority: 2

  index_as_calendar do |item|
    {
      id: item.id,
      title: item.title.presence || "No title",
      start: item.report_date,
      url: admin_daily_report_path(item),
      textColor: "white"
    }
  end
end
