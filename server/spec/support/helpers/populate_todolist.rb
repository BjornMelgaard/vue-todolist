module PopulateTodolist
  def populate_todolist(
    user,
    projects_count:,
    tasks_per_project:,
    comments_per_task:,
    attachments_per_comment:
  )
    projects = create_list(:project, projects_count, user: user)

    tasks = projects.map do |parent|
      create_list(:task, tasks_per_project, project: parent)
    end.flatten

    comments = tasks.map do |parent|
      create_list(:comment, comments_per_task, task: parent)
    end.flatten

    attachments = comments.map do |parent|
      create_list(:attachment, attachments_per_comment, comment: parent)
    end.flatten

    {
      projects:    projects,
      tasks:       tasks,
      comments:    comments,
      attachments: attachments
    }
  end
end

RSpec.configure do |config|
  config.include PopulateTodolist
end
