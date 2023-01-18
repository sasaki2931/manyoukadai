require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in'task[name]',with:'task'
        fill_in'task[content]',with:'task'
        fill_in'task[deadline]',with:'task'
        fill_in'task[deadline]',with'task'
        click_button'commit'
        expect(page).to have_content 'task'

      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        visit tasks_path
        # binding.irb
        task_list = all('.task_row') 
        expect(task_list[0]).to have_content 'test_content2'
        expect(task_list[1]).to have_content 'test_content1'
      end
    end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        visit tasks_path
        click_link'終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '2002-2-2'
        expect(task_list[1]).to have_content '2001-1-1'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, name: 'task')
        visit task_path(@task.id)
        expect(page).to have_content 'task'
       end
     end
  end
  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task")
      FactoryBot.create(:second_task, title: "sample")
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in "selection-field",with:"task"
        click_button 'Seach'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select 'not_started',from: 'enum'
        click_button 'Seach'
        expect(page).to have_content 'not_started'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in "selection-field",with:"task"
        select 'not_started',from: 'enum'
        click_button 'Seach'
        expect(page).to have_content 'not_started'
        expect(page).to have_content 'task'
        # ここに実装する
      end
    end
  end
end