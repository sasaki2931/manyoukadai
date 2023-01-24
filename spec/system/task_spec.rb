require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:user) {FactoryBot.create(:user)}
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    describe do
      before do
        visit new_session_path
        fill_in'session[email]',with:'test@test.com'
        fill_in'session[password]',with:'testtest'
        click_button'Log in'
      end
  describe '新規作成機能' do

    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in'task[name]',with:'test'
        fill_in'task[content]',with:'test'
        fill_in'task[deadline]',with:'2011-01-01'
        click_button'commit'
        sleep(5)
        expect(page).to have_content 'test'

      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row') 
        expect(task_list[0]).to have_content 'test_content2'
       
      end
    end
  end
  context '終了期限でソートする場合' do
    it '終了期限が降順で表示される' do
      visit tasks_path
      click_link'終了期限でソートする'
      sleep(5)
      #binding.irb
      task_list = all('.task_row')
      expect(task_list[0]).to have_content '2002-02-02'
      expect(task_list[1]).to have_content '2001-01-01'
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, user: user)
        visit task_path(task.id)
        expect(page).to have_content 'test'
      end
    end
  end
  describe '検索機能' do

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in "task[search]",with:"task"
        click_button 'Search'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '未着手',from: 'task[status]'
        click_button 'Search'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "task[search]",with:"task"
        select '未着手',from: 'task[status]'
        click_button 'Search'
        expect(page).to have_content '未着手'
        expect(page).to have_content 'task'
        # ここに実装する
      end
    end
  end
end
end