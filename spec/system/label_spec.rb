require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
    let(:user) {FactoryBot.create(:user)}
    let!(:task) { FactoryBot.create(:task, user: user) }
    describe do
        before do
          visit new_session_path
          fill_in'session[email]',with:'test@test.com'
          fill_in'session[password]',with:'testtest'
          click_button'Log in'
        end
        context 'タスクを新規作成した場合' do
            it '作成したラベルが表示される' do
              visit new_task_path
              fill_in'task[name]',with:'test'
              fill_in'task[content]',with:'test'
              fill_in'task[deadline]',with:'2011-01-01'
              check 'task_label_ids_1'
              click_button'commit'
              expect(page).to have_content '1'
            end
        end
        context 'タスク詳細に移行した場合' do
          it "ラベルが表示される" do
           visit tasks_path
            sleep(5)
            click_link '詳細を確認する'
            expect(page).to have_content '1'
          end
        end
        context 'ラベル検索をした場合' do
            it "ラベルに完全一致するタスクが絞り込まれる" do
                visit tasks_path
               
              select '1',from: 'task_label_id'
              click_button 'Search'
              expect(page).to have_content '1'
            end
        end
    end
end