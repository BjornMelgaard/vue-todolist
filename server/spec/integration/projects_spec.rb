# feature 'Projects', :user_exists do
#   before do
#     populate_todolist(user)
#     authenticate(user)
#   end
#
#   scenario 'can create project' do
#     project_params = attributes_for(:project)
#
#     sleep 0.5; require 'pry'; ::Kernel.binding.pry;
#     find_button('Add TODO List').click
#     find(:css, '.project-field input').set(project_params[:name] + "\n")
#
#     expect(page).to have_content(project_params[:name])
#     expect(page).to have_css('.create-task-header')
#     expect(Project.count).to eq(1)
#   end
#
#   scenario 'can update project' do
#     project = create(:project, user: user)
#     new_name = 'new name'
#
#     visit root_path
#     find('button.edit').click
#     find(:css, '.project-field input').set(new_name + "\n")
#     expect(page).to have_content(new_name)
#     expect(project.reload.name).to eq new_name
#   end
#
#   scenario 'can delete project' do
#     create(:project, user: user)
#     visit root_path
#     expect do
#       find('button.delete').click
#       expect(page).not_to have_css('.project')
#     end.to change(Project, :count).by(-1)
#   end
# end
