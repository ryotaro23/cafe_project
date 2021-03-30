require 'rails_helper'

describe 'ユーザログイン後のテスト' do

    let(:user) { create(:user) }
    let(:time_table) { create(:time_table) }
    let(:event) { create(:event, time_id: time_table.id) }
    let(:event_3in) { create(:event, time_id: time_table.id, date: Date.today+1, max_num: 10) }
    let(:event_3out) { create(:event, time_id: time_table.id, date: Date.today+5, max_num: 10) }
    let(:event_out) { create(:event, time_id: time_table.id, date: Date.today-3, max_num: 10) }
    let(:event_max_1) { create(:event, time_id: time_table.id, max_num: 1) }

    before do
        # 開始3日以内, 開始3日以前, 終了済みの3パターンで分類
        visit user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
    end

    describe 'ヘッダーのテスト: ログインしている場合' do
        context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
            subject { current_path }

            before do
                visit root_path
            end

            it 'ヘッダーロゴのルーティング' do
                # expect(page).to have_content '間違っています'
                logo = find_by_id('header-logo')
                logo.click
                is_expected.to eq '/'
            end

            it '代表者挨拶のルーティング' do
                click_on '代表者挨拶'
                is_expected.to eq '/events/greeting'
            end

            it 'マイページのルーティング' do
                click_on 'マイページ'
                is_expected.to eq '/users/' + user.id.to_s
            end

            it 'ヘッダーに新規登録とログインがないことを確認する' do
                expect(page).to have_no_xpath '//a[contains(text(), "新規登録")]'
                expect(page).to have_no_xpath '//a[contains(text(), "新規登録")]'
            end
        end
    end

    describe 'イベント一覧画面のテスト' do

        before do
            create(:event, time_id: time_table.id, name: "sample1")
            visit events_path
        end

        context '表示内容の確認' do
            it 'URLが正しい' do
                expect(current_path).to eq '/events'
            end
            it '「イベント一覧」と表示される' do
                expect(page).to have_content 'イベント一覧'
            end
            it 'イベントの名前が表示される' do
                expect(page).to have_content "sample1"
            end
            it 'イベントの名前をクリックして詳細画面に飛べる' do
                click_on 'sample1'
                expect(page).to have_content "sample1"
            end
        end
    end

    # TODO: 開催済みとかが時間によって入れ替わってErrorになる
    # describe '1週間以内のイベント' do

    #     before do
    #         create(:event, time_id: time_table.id, name: "sample2",date: Date.today+1 )         #0: 一週間以内
    #         create(:event, time_id: time_table.id, name: "sample3",date: Date.today+10 )        #1: 一週間以上後
    #         create(:event, time_id: time_table.id, name: "sample4",date: Date.today-1 )         #2: 経過後
    #         visit events_path
    #     end

    #     context '表示内容の確認' do
    #         it '一週間以内のイベントであることが表示されている' do
    #             whithin7Day = all(".event-all__menu__item__content")[0]
    #             expect(whithin7Day).to have_content "開催済み"
    #         end
    #         it 'イベントの名前をクリックして詳細画面に飛べる' do
    #             click_on 'sample2'
    #             expect(page).to have_content "sample2"
    #         end
    #         it '一週間以内のイベントであることが表示されている' do
    #             afterEvent = all(".event-all__menu__item__content")[1]
    #             expect(afterEvent).to have_content "1週間以内のイベント！！"
    #         end
    #         it '一週間以内のイベントであることが表示されている' do
    #             more7Day = all(".event-all__menu__item__content")[2]
    #             expect(more7Day).to have_no_content "1週間以内のイベント！！"
    #             expect(more7Day).to have_no_content "開催済み"
    #         end
    #     end

    end

    describe '3日以内のイベントのテスト' do
        before do
            visit event_path(event_3in)
        end

        context '3日以内のイベントのテスト' do
            it 'URLが正しい' do
                expect(current_path).to eq '/events/' + event_3in.id.to_s
            end
            it '参加可能の表示がされる' do
                expect(page).to have_content "参加可能"
            end
            it '参加するボタンを押すと参加人数が増える' do
                expect(page).to have_content "0/"
                expect(page).to have_content "参加する"
                click_on '参加する'
                expect(page).to have_content "1/"
            end
            it '一度参加ボタンを押すとキャンセル不可にできる' do
                click_on '参加する'
                expect(page).to have_content "キャンセル不可"
            end
            it 'cssを変更してキャンセル不可を押してもroot_pathへ飛ばす' do
                click_on '参加する'
                expect(page).to have_content "キャンセル不可"
                click_on 'キャンセル不可'
                expect(current_path).to eq root_path
            end
        end
    end

    describe '3日以上空いているときのテスト' do
        before do
            visit event_path(event_3out)
        end

        context '3日以上空いているときのテスト' do
            it 'URLが正しい' do
                expect(current_path).to eq '/events/' + event_3out.id.to_s
            end
            it '参加可能の表示がされる' do
                expect(page).to have_content "参加可能"
            end
            it '参加するボタンを押すと参加人数が増える' do
                expect(page).to have_content "0/"
                expect(page).to have_content "参加する"
                click_on '参加する'
                expect(page).to have_content "1/"
            end
            it '参加すると参加取り消しボタンに変更できる' do
                click_on '参加する'
                expect(page).to have_content "参加取り消し"
            end
            it '参加取り消しをすると人数を減らせる' do
                click_on '参加する'
                expect(page).to have_content "1/"
                expect(page).to have_content "参加取り消し"
                click_on '参加取り消し'
                expect(page).to have_content "0/"
            end
        end
    end

    describe '終了済みのイベントのテスト' do
        before do
            visit event_path(event_out)
        end

        context '終了済みのイベントのテスト' do
            it 'URLが正しい' do
                expect(current_path).to eq '/events/' + event_out.id.to_s
            end
            it '終了済みボタンが表示される' do
                expect(page).to have_content "終了済み"
            end
            it 'cssを変更して終了済みを押されてもroot_pathに飛ばされる' do
                click_on '終了済み'
                expect(current_path).to eq root_path
            end
        end
    end

end

#     context 'サイドバーの確認' do
#       it '自分の名前と紹介文が表示される' do
#         expect(page).to have_content user.name
#         expect(page).to have_content user.introduction
#       end
#       it '自分のユーザ編集画面へのリンクが存在する' do
#         expect(page).to have_link '', href: edit_user_path(user)
#       end
#       it '「New book」と表示される' do
#         expect(page).to have_content 'New book'
#       end
#       it 'titleフォームが表示される' do
#         expect(page).to have_field 'book[title]'
#       end
#       it 'titleフォームに値が入っていない' do
#         expect(find_field('book[title]').text).to be_blank
#       end
#       it 'opinionフォームが表示される' do
#         expect(page).to have_field 'book[body]'
#       end
#       it 'opinionフォームに値が入っていない' do
#         expect(find_field('book[body]').text).to be_blank
#       end
#       it 'Create Bookボタンが表示される' do
#         expect(page).to have_button 'Create Book'
#       end
#     end

#     context '投稿成功のテスト' do
#       before do
#         fill_in 'book[title]', with: Faker::Lorem.characters(number: 5)
#         fill_in 'book[body]', with: Faker::Lorem.characters(number: 20)
#       end

#       it '自分の新しい投稿が正しく保存される' do
#         expect { click_button 'Create Book' }.to change(user.books, :count).by(1)
#       end
#     end

#     context '編集リンクのテスト' do
#       it '編集画面に遷移する' do
#         click_link 'Edit'
#         expect(current_path).to eq '/books/' + book.id.to_s + '/edit'
#       end
#     end

#     context '削除リンクのテスト' do
#       before do
#         click_link 'Destroy'
#       end

#       it '正しく削除される' do
#         expect(Book.where(id: book.id).count).to eq 0
#       end
#       it 'リダイレクト先が、投稿一覧画面になっている' do
#         expect(current_path).to eq '/books'
#       end
#     end
    # end

#   describe '自分の投稿編集画面のテスト' do
#     before do
#       visit edit_book_path(book)
#     end

#     context '表示の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/books/' + book.id.to_s + '/edit'
#       end
#       it '「Editing Book」と表示される' do
#         expect(page).to have_content 'Editing Book'
#       end
#       it 'title編集フォームが表示される' do
#         expect(page).to have_field 'book[title]', with: book.title
#       end
#       it 'opinion編集フォームが表示される' do
#         expect(page).to have_field 'book[body]', with: book.body
#       end
#       it 'Update Bookボタンが表示される' do
#         expect(page).to have_button 'Update Book'
#       end
#       it 'Showリンクが表示される' do
#         expect(page).to have_link 'Show', href: book_path(book)
#       end
#       it 'Backリンクが表示される' do
#         expect(page).to have_link 'Back', href: books_path
#       end
#     end

#     context '編集成功のテスト' do
#       before do
#         @book_old_title = book.title
#         @book_old_body = book.body
#         fill_in 'book[title]', with: Faker::Lorem.characters(number: 4)
#         fill_in 'book[body]', with: Faker::Lorem.characters(number: 19)
#         click_button 'Update Book'
#       end

#       it 'titleが正しく更新される' do
#         expect(book.reload.title).not_to eq @book_old_title
#       end
#       it 'bodyが正しく更新される' do
#         expect(book.reload.body).not_to eq @book_old_body
#       end
#       it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
#         expect(current_path).to eq '/books/' + book.id.to_s
#         expect(page).to have_content 'Book detail'
#       end
#     end
#   end

#   describe 'ユーザ一覧画面のテスト' do
#     before do
#       visit users_path
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/users'
#       end
#       it '自分と他人の画像が表示される: fallbackの画像がサイドバーの1つ＋一覧(2人)の2つの計3つ存在する' do
#         expect(all('img').size).to eq(3)
#       end
#       it '自分と他人の名前がそれぞれ表示される' do
#         expect(page).to have_content user.name
#         expect(page).to have_content other_user.name
#       end
#       it '自分と他人のshowリンクがそれぞれ表示される' do
#         expect(page).to have_link 'Show', href: user_path(user)
#         expect(page).to have_link 'Show', href: user_path(other_user)
#       end
#     end

#     context 'サイドバーの確認' do
#       it '自分の名前と紹介文が表示される' do
#         expect(page).to have_content user.name
#         expect(page).to have_content user.introduction
#       end
#       it '自分のユーザ編集画面へのリンクが存在する' do
#         expect(page).to have_link '', href: edit_user_path(user)
#       end
#       it '「New book」と表示される' do
#         expect(page).to have_content 'New book'
#       end
#       it 'titleフォームが表示される' do
#         expect(page).to have_field 'book[title]'
#       end
#       it 'titleフォームに値が入っていない' do
#         expect(find_field('book[title]').text).to be_blank
#       end
#       it 'opinionフォームが表示される' do
#         expect(page).to have_field 'book[body]'
#       end
#       it 'opinionフォームに値が入っていない' do
#         expect(find_field('book[body]').text).to be_blank
#       end
#       it 'Create Bookボタンが表示される' do
#         expect(page).to have_button 'Create Book'
#       end
#     end
#   end

#   describe '自分のユーザ詳細画面のテスト' do
#     before do
#       visit user_path(user)
#     end

#     context '表示の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/users/' + user.id.to_s
#       end
#       it '投稿一覧のユーザ画像のリンク先が正しい' do
#         expect(page).to have_link '', href: user_path(user)
#       end
#       it '投稿一覧に自分の投稿のtitleが表示され、リンクが正しい' do
#         expect(page).to have_link book.title, href: book_path(book)
#       end
#       it '投稿一覧に自分の投稿のopinionが表示される' do
#         expect(page).to have_content book.body
#       end
#       it '他人の投稿は表示されない' do
#         expect(page).not_to have_link '', href: user_path(other_user)
#         expect(page).not_to have_content other_book.title
#         expect(page).not_to have_content other_book.body
#       end
#     end

#     context 'サイドバーの確認' do
#       it '自分の名前と紹介文が表示される' do
#         expect(page).to have_content user.name
#         expect(page).to have_content user.introduction
#       end
#       it '自分のユーザ編集画面へのリンクが存在する' do
#         expect(page).to have_link '', href: edit_user_path(user)
#       end
#       it '「New book」と表示される' do
#         expect(page).to have_content 'New book'
#       end
#       it 'titleフォームが表示される' do
#         expect(page).to have_field 'book[title]'
#       end
#       it 'titleフォームに値が入っていない' do
#         expect(find_field('book[title]').text).to be_blank
#       end
#       it 'opinionフォームが表示される' do
#         expect(page).to have_field 'book[body]'
#       end
#       it 'opinionフォームに値が入っていない' do
#         expect(find_field('book[body]').text).to be_blank
#       end
#       it 'Create Bookボタンが表示される' do
#         expect(page).to have_button 'Create Book'
#       end
#     end
#   end

#   describe '自分のユーザ情報編集画面のテスト' do
#     before do
#       visit edit_user_path(user)
#     end

#     context '表示の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
#       end
#       it '名前編集フォームに自分の名前が表示される' do
#         expect(page).to have_field 'user[name]', with: user.name
#       end
#       it '画像編集フォームが表示される' do
#         expect(page).to have_field 'user[profile_image]'
#       end
#       it '自己紹介編集フォームに自分の自己紹介文が表示される' do
#         expect(page).to have_field 'user[introduction]', with: user.introduction
#       end
#       it 'Update Userボタンが表示される' do
#         expect(page).to have_button 'Update User'
#       end
#     end

#     context '更新成功のテスト' do
#       before do
#         @user_old_name = user.name
#         @user_old_intrpduction = user.introduction
#         fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
#         fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
#         click_button 'Update User'
#       end

#       it 'nameが正しく更新される' do
#         expect(user.reload.name).not_to eq @user_old_name
#       end
#       it 'introductionが正しく更新される' do
#         expect(user.reload.introduction).not_to eq @user_old_intrpduction
#       end
#       it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
#         expect(current_path).to eq '/users/' + user.id.to_s
#       end
#     end
#   end
