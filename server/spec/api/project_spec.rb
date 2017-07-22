require 'rails_helper'

RSpec.describe 'Project: ', type: :request do
  describe 'show', create_user: true do
    let!(:projects) { create_list(:project, 2, user: user) }
    let!(:other_user) { create :user }
    let!(:other_projects) { create_list(:project, 2, user: other_user) }

    def project_request(id, headers: nil)
      graphql_request <<~GRAPH, headers: headers
        query=query {
          project(id: "#{id}") {
            name,
            id
          }
        }
      GRAPH
    end

    it 'error when not signed' do
      project_request(projects.first.id)
      expect_json_types('data', project: :null)
      expect_json('errors.0.message', 'must be logged in')
    end

    it 'error when not owner' do
      project_request(other_projects.first.id, headers: auth_headers)
      expect_json_types('data', project: :null)
      expect_json('errors.0.message', 'not allowed to show')
    end

    it 'success when owner' do
      project = projects.first
      project_request(project.id, headers: auth_headers)
      expect_json_types(errors: :null)
      expect_json('data.project', name: project.name, id: project.id)
    end
  end

  describe 'index', create_user: true do
    let(:magic_number) { 3 }
    let!(:todolist) do
      populate_todolist(
        user,
        projects_count:          magic_number,
        tasks_per_project:       magic_number,
        comments_per_task:       magic_number,
        attachments_per_comment: magic_number
      )
    end

    def projects_request(headers: nil)
      graphql_request queryfile_content('readTodolist'), headers: headers
    end

    it 'returns only user projects' do
      projects_request(headers: auth_headers)
      expect_json_sizes('data.projects.edges', magic_number)

      # TODO: wait bug https://github.com/brooklynDev/airborne/issues/139
      expect_json_sizes('data.projects.edges.0.node.tasks.edges', 3)
      expect_json_sizes('data.projects.edges.1.node.tasks.edges', 3)
      expect_json_sizes('data.projects.edges.2.node.tasks.edges', 3)
      # expect_json_sizes('data.projects.edges.*.node.tasks.edges', 3)
    end
  end

  describe 'create', create_user: true do
    def create_request(name, headers: nil)
      graphql_request <<~GRAPH, headers: headers
        query=mutation {
          createProject(input: {
            name: "#{name}",
          }) {
            project {
              id
              name
            }
          }
        }
      GRAPH
    end

    it 'success' do
      name = 'Valid name'
      create_request name, headers: auth_headers
      json = { data: { createProject: { project: { id: 1, name: name } } } }
      expect_json(json)
    end

    it 'error on empty name' do
      create_request '', headers: auth_headers
      json = { data: { createProject: nil },
               errors: [{ message: 'Some of your changes could not be saved.',
                          kind: 'INVALID_ARGUMENTS',
                          invalidArguments: { name: "can't be blank" },
                          unknownErrors: [],
                          locations: [{ line: 2, column: 3 }] }] }
      expect_json(json)
    end
  end

  describe 'update', create_user: true do
    let!(:project)       { create :project, user: user }
    let!(:other_user)    { create :user }
    let!(:other_project) { create :project, user: other_user }

    def update_request(id, name, headers: nil)
      graphql_request <<~GRAPH, headers: headers
        query=mutation {
          updateProject(input: {
            id: "#{id}",
            name: "#{name}",
          }) {
            project {
              id
              name
            }
          }
        }
      GRAPH
    end

    it 'success' do
      name = 'Valid name'
      update_request project.id, name, headers: auth_headers
      json = { data: { updateProject: { project: { id: 1, name: name } } } }
      expect_json(json)
    end

    it 'error if not owner' do
      name = 'Valid name'
      update_request other_project.id, name, headers: auth_headers
      json = { data: { updateProject: nil },
               errors: [{ message: 'not allowed to update this Project',
                          locations: [{ line: 2, column: 3 }],
                          path: ['updateProject'] }] }
      expect_json(json)
    end
  end

  describe 'destroy', create_user: true do
    let!(:project)       { create :project, user: user }
    let!(:other_user)    { create :user }
    let!(:other_project) { create :project, user: other_user }

    def destroy_request(id, headers: nil)
      graphql_request <<~GRAPH, headers: headers
        query=mutation {
          destroyProject(input: {
            id: "#{id}"
          }) {
            project {
              id
              name
            }
          }
        }
      GRAPH
    end

    it 'success' do
      destroy_request project.id, headers: auth_headers
      json = { data: { destroyProject: { project: { id: project.id, name: project.name } } } }
      expect_json(json)
    end

    it 'error if not owner' do
      destroy_request other_project.id, headers: auth_headers
      json = { data: { destroyProject: nil },
               errors: [{ message: 'not allowed to destroy this Project',
                          locations: [{ line: 2, column: 3 }],
                          path: ['destroyProject'] }] }
      expect_json(json)
    end
  end
end
