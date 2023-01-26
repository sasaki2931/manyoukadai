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
            fill_in'session[email]',with:'test@test.com'
            fill_in'session[password]',with:'testtest'
            click_button "Log in"
            expect(page).to have_content 'のページ'
          end
        end
        context '他人の詳細画面にとんだ場合' do
            it 'タスク一覧に戻ること' do
              visit tasks_path
              expect(current_path).to eq new_session_path
              expect(current_path).not_to eq tasks_path
            end
        end
        context 'ログアウトボタンを押した場合' do
            it 'ログアウトできること' do
                FactoryBot.create(:user)
                visit new_session_path
                fill_in'session[email]',with:'test@test.com'
                fill_in'session[password]',with:'testtest'
                click_button "Log in"
                click_link "Logout"
                expect(page).to have_content 'ログアウトしました'
            end
        end
    end
    describe '管理者権限' do
        context '管理者がログインした場合' do
            it '管理画面にとぶ' do
                FactoryBot.create(:user2)
                visit new_session_path
                fill_in'session[email]',with:'test2@test.com'
                fill_in'session[password]',with:'test2test2'
                sleep(3)
                click_button "Log in"
                expect(page).to have_content 'ユーザー一覧'
                sleep(3)
              end
            end
            context '一般ユーザーが管理画面にアクセスした場合' do
              it 'アクセスできない' do
                FactoryBot.create(:user2)
                FactoryBot.create(:user)
                visit new_session_path
                fill_in'session[email]',with:'test@test.com'
                fill_in'session[password]',with:'testtest'
                click_button "Log in"
                click_link "管理者ページへ"
                expect(page).to have_content '管理者以外アクセスできません'
              end
            end
            context '管理ユーザーがユーザを作成した時' do
              it '新規登録できる' do
                user = FactoryBot.create(:user2)
                visit new_session_path
                fill_in'session[email]',with:'test2@test.com'
                fill_in'session[password]',with:'test2test2'
                click_button "Log in"
                click_link"新しくユーザーを作成する"

                fill_in'user[name]',with:'user3'
                fill_in'user[email]',with:'user3@gmail.com'
                fill_in'user[password]',with:'user3@gmail.com'
                fill_in'user[password_confirmation]',with:'user3@gmail.com'
                click_button "Create  account"
                expect(page).to have_content 'のページ'
              end    
            end
            context '管理ユーザーが一覧画面で' do
              it '詳細画面にアクセスできる' do    
                user = FactoryBot.create(:user2)
                visit new_session_path
                fill_in'session[email]',with:'test2@test.com'
                fill_in'session[password]',with:'test2test2'
                click_button "Log in"
             
                
        
                click_link 'user詳細'
                expect(page).to have_content 'のタスク一覧'
              end
            end
            context '管理ユーザーが編集画面で' do
              it 'ユーザーを編集できる' do    
                user = FactoryBot.create(:user2)
                visit new_session_path
                fill_in'session[email]',with:'test2@test.com'
                fill_in'session[password]',with:'test2test2'
                click_button "Log in"
              
                click_link"userを編集する"
                
                fill_in'user[name]',with:'user3'
                fill_in'user[email]',with:'user3@gmail.com'
                fill_in'user[password]',with:'user3@gmail.com'
                fill_in'user[password_confirmation]',with:'user3@gmail.com'
                click_button 'Create  account'
                expect(page).to have_content  "ユーザー一覧" 
              end
            end
            context '管理ユーザーが一覧画面で' do
              it 'ユーザーを削除できる' do    
                user = FactoryBot.create(:user2)
                visit new_session_path
                fill_in'session[email]',with:'test2@test.com'
                fill_in'session[password]',with:'test2test2'
                click_button "Log in"
               

                click_link 'userを削除する'
                expect {
                    page.accept_confirm "本当に削除しますか？" 
                    expect(page).to have_content "ユーザを削除しました" }
              
              end
            end
            
            
        end
end