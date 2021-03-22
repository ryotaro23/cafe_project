require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:event_join) { create(:event_join) }

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    describe 'ヘッダーのテスト: ログインしていない場合' do
      context 'ヘッダーのルーティングの確認' do
        subject { current_path }

        it '新規登録のルーティング' do
            # click_on '新規登録'
            find(:xpath, '//a[contains(text(), "新規登録")]').click
            is_expected.to eq '/users/sign_up'
        end

        it 'ログインのルーティング' do
            find(:xpath, '//a[contains(text(), "ログイン")]').click
            # click_on 'ログイン'
            is_expected.to eq '/users/sign_in'
        end

        it 'ヘッダーに新規登録とログインがないことを確認する' do
            expect(page).to have_no_content 'マイページ'
            expect(page).to have_no_content 'ログアウト'
        end

      end

    end
  end

  describe 'トップ画面のテスト' do

    before do
      visit root_path
    end

    context '表示内容の確認' do

      it 'ログインボタンからログイン処理ができるか確かめる' do
        find(:xpath, '//a[contains(@class, "event-top__btn login")]').click
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit '/users/' + user.id.to_s
        expect(page).to have_content '参加予定の活動'
      end
    end
  end

  describe 'ログインテスト' do
    before do
      visit new_user_session_path
    end

    context 'ログイン後のルーティング' do
      it 'URLが正しい' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(current_path).to eq '/'
      end
    end

    context 'ログインのエラー' do

      it 'emailかパスワードが間違っている' do
        fill_in 'user[email]', with: user.email + 'miss'
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'アカウントが見つかりません'
      end

      it 'emailはあっているがパスワードが間違っている' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: '11111111'
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content '間違っています'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'universityフォームが表示される' do
        expect(page).to have_field 'user[university]'
      end
      it '登録ボタンが表示される' do
        expect(page).to have_field 'user[grade]'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        fill_in 'user[university]', with:  '東北大学'
        select '1年生', from: 'Grade'
      end

      it '正しく新規登録される' do
        expect { click_button '登録' }.to change(User.all, :count).by(1)
      end

      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '登録'
        expect(current_path).to eq root_path
      end
    end

    context '新規登録失敗のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: 'pass'
        fill_in 'user[password_confirmation]', with: 'missw'
        fill_in 'user[university]', with:  'マサチューセッツ工科大学'
        select '1年生', from: 'Grade'
      end

      it 'エラーメッセージが全てが表示されるか？' do
        fill_in 'user[password]', with: 'passwor'
        click_button '登録'
      end

      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '登録'
        expect(page).to have_content '一致しません'
        expect(page).to have_content '6文字以上'
        expect(page).to have_content '存在します'
      end
    end
  end

end

  #   context 'リンクの内容を確認' do
  #     subject { current_path }

  #     it 'Homeを押すと、トップ画面に遷移する' do
  #       home_link = find_all('a')[1].native.inner_text
  #       home_link = home_link.delete(' ')
  #       home_link.gsub!(/\n/, '')
  #       click_link home_link
  #       is_expected.to eq '/'
  #     end
  #     it 'Aboutを押すと、アバウト画面に遷移する' do
  #       about_link = find_all('a')[2].native.inner_text
  #       about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
  #       click_link about_link
  #       is_expected.to eq '/home/about'
  #     end
  #     it 'sign upを押すと、新規登録画面に遷移する' do
  #       signup_link = find_all('a')[3].native.inner_text
  #       signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
  #       click_link signup_link
  #       is_expected.to eq '/users/sign_up'
  #     end
  #     it 'loginを押すと、ログイン画面に遷移する' do
  #       login_link = find_all('a')[4].native.inner_text
  #       login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
  #       click_link login_link
  #       is_expected.to eq '/users/sign_in'
  #     end
  #   end
  # end

  # describe 'ユーザログイン' do
  #   let(:user) { create(:user) }

  #   before do
  #     visit new_user_session_path
  #   end

  #   context '表示内容の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/users/sign_in'
  #     end
  #     it '「Log in」と表示される' do
  #       expect(page).to have_content 'Log in'
  #     end
  #     it 'nameフォームが表示される' do
  #       expect(page).to have_field 'user[name]'
  #     end
  #     it 'passwordフォームが表示される' do
  #       expect(page).to have_field 'user[password]'
  #     end
  #     it 'Sign upボタンが表示される' do
  #       expect(page).to have_button 'Log in'
  #     end
  #     it 'emailフォームは表示されない' do
  #       expect(page).not_to have_field 'user[email]'
  #     end
  #   end

  #   context 'ログイン成功のテスト' do
  #     before do
  #       fill_in 'user[name]', with: user.name
  #       fill_in 'user[password]', with: user.password
  #       click_button 'Log in'
  #     end

  #     it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
  #       expect(current_path).to eq '/users/' + user.id.to_s
  #     end
  #   end

  #   context 'ログイン失敗のテスト' do
  #     before do
  #       fill_in 'user[name]', with: ''
  #       fill_in 'user[password]', with: ''
  #       click_button 'Log in'
  #     end

  #     it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
  #       expect(current_path).to eq '/users/sign_in'
  #     end
  #   end
  # end

  # describe 'ヘッダーのテスト: ログインしている場合' do
  #   let(:user) { create(:user) }

  #   before do
  #     visit new_user_session_path
  #     fill_in 'user[name]', with: user.name
  #     fill_in 'user[password]', with: user.password
  #     click_button 'Log in'
  #   end

  #   context 'ヘッダーの表示を確認' do
  #     it 'タイトルが表示される' do
  #       expect(page).to have_content 'Bookers'
  #     end
  #     it 'Homeリンクが表示される: 左上から1番目のリンクが「Home」である' do
  #       home_link = find_all('a')[1].native.inner_text
  #       expect(home_link).to match(/home/i)
  #     end
  #     it 'Usersリンクが表示される: 左上から2番目のリンクが「Users」である' do
  #       users_link = find_all('a')[2].native.inner_text
  #       expect(users_link).to match(/users/i)
  #     end
  #     it 'Booksリンクが表示される: 左上から3番目のリンクが「Books」である' do
  #       books_link = find_all('a')[3].native.inner_text
  #       expect(books_link).to match(/books/i)
  #     end
  #     it 'log outリンクが表示される: 左上から4番目のリンクが「logout」である' do
  #       logout_link = find_all('a')[4].native.inner_text
  #       expect(logout_link).to match(/logout/i)
  #     end
  #   end
  # end

  # describe 'ユーザログアウトのテスト' do
  #   let(:user) { create(:user) }

  #   before do
  #     visit new_user_session_path
  #     fill_in 'user[name]', with: user.name
  #     fill_in 'user[password]', with: user.password
  #     click_button 'Log in'
  #     logout_link = find_all('a')[4].native.inner_text
  #     logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
  #     click_link logout_link
  #   end

  #   context 'ログアウト機能のテスト' do
  #     it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
  #       expect(page).to have_link '', href: '/home/about'
  #     end
  #     it 'ログアウト後のリダイレクト先が、トップになっている' do
  #       expect(current_path).to eq '/'
  #     end
  #   end
  # end
# end
