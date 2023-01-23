require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do
    describe '新規ユーザ登録' do
      context 'ユーザーを新規登録した場合' do
        it '新規登録ができる' do
          user = FactoryBot.create(:user)
          visit new_user_path
          fill_in'user[name]',with:'user1'
          fill_in'user[email]',with:'user1@gmail.com'
          fill_in'user[password]',with:'user1@gmail.com'
          fill_in'user[password_confirmation]',with:'user1@gmail.com'
          click_button "Create my account"
          expect(page).to have_content 'のページ'
        end
      end
      context 'ログインせずにタスク一覧に飛ぼうとした場合' do
        it 'ログイン画面に移行する' do
          visit tasks_path
          expect(page).to have_content 'Sign up'
        end
      end
    end
    describe 'ログイン機能' do
        context 'ログインした場合' do
          it 'ログインしマイページに飛べること' do
            FactoryBot.create(:user)
            visit new_session_path
            fill_in'session[name]',with:'user1'
            fill_in'session[password]',with:'user1@gmail.com'
            click_button "Log in"
            expect(page).to have_content 'のページ'
          end
        end
        context '他人の詳細画面にとんだ場合' do
            it 'タスク一覧に戻ること' do
              user =FactoryBot.create(:user)
              user2 = FactoryBot.create(:top_user)
              visit new_session_path
              fill_in'session[name]',with:'user1'
              fill_in'session[password]',with:'user1@gmail.com'
              click_button "Log in"
              visit user_path(user2.id)
              expect(page).to have_content 'Task一覧'
            end
        end
        context 'ログアウトボタンを押した場合' do
            it 'ログアウトできること' do
              user =FactoryBot.create(:user)
             
              visit user_path
              clicl_link
              fill_in'session[name]',with:'user1'
              fill_in'session[password]',with:'user1@gmail.com'
              click_button "Logout"
              visit new_sessions_path
              expect(page).to have_content 'ロフアウトしました'
            end
        end
    end
        describe '管理者権限' do
            context '管理者がログインした場合' do
              it '管理画面にとぶ' do
                FactoryBot.create(:top_user)
                visit new_session_path
                fill_in'session[email]',with:'user1'
                fill_in'session[password]',with:'user1@gmail.com'
                click_button "Log in"
                expect(page).to have_content 'ユーザー一覧'
              end
            end
            context '一般ユーザーが管理画面にアクセスした場合' do
              it 'アクセスできない' do
                FactoryBot.create(:top_user)
                FactoryBot.create(:user)
                visit new_session_path
                fill_in'session[email]',with:'user2'
                fill_in'session[password]',with:'user2@gmail.com'
                click_button "Log in"
                click_link "管理者ページへ"
                expect(page).to have_content '管理者以外アクセスできません'
              end
            end
            context '管理ユーザーがユーザを作成した時' do
              it '新規登録できる' do
                user = FactoryBot.create(:user)
                visit admin_new_user_path
                fill_in'user[name]',with:'user3'
                fill_in'user[email]',with:'user3@gmail.com'
                fill_in'user[password]',with:'user3@gmail.com'
                fill_in'user[password_confirmation]',with:'user3@gmail.com'
                fill_in'user[admin]',with:'false'
                click_button "Create account"
                expect(page).to have_content 'のページ'
              end    
            end
            context '管理ユーザーが一覧画面で' do
              it '詳細画面にアクセスできる' do    
                user = FactoryBot.create(:user)
                visit admin_user_path
                click_link 'user詳細'
                expect(page).to have_content 'のタスク一覧'
              end
            end
            context '管理ユーザーが編集画面で' do
              it 'ユーザーを編集できる' do    
                user = FactoryBot.create(:user)
                visit admin_edit_user_path
                fill_in'user[name]',with:'user3'
                fill_in'user[email]',with:'user3@gmail.com'
                fill_in'user[password]',with:'user3@gmail.com'
                fill_in'user[password_confirmation]',with:'user3@gmail.com'
                fill_in'user[admin]',with:'false'
                click_button 'Create account'
                expect(page).to have_content 'ユーザ一覧'
              end
            end
            context '管理ユーザーが一覧画面で' do
              it 'ユーザーを削除できる' do    
                user = FactoryBot.create(:user)
                visit admin_user_path
                click_link 'ユーザーを削除する'
                expect(page).to have_content 'ユーザーを削除しました'
              end
            end
            
            
        end
end