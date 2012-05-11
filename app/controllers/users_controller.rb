class UsersController < ApplicationController
  # ユーザーの一覧を取得します
  #
  # すべてのユーザーの情報を返します
  #
  # @param <string> format レスポンス形式(json, html)
  #
  # @response json
  #   [
  #     {
  #       "id": 1,
  #       "name": "rosylilly",
  #       "created_at": "2012-05-01 12:00:00"
  #     },
  #     {
  #       "id": 2,
  #       "name": "sho_kusano",
  #       "created_at": "2012-05-01 12:00:00"
  #     }
  #   ]
  #
  # @todo XMLでのレスポンスにも対応しよう
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # 特定のユーザーの情報を取得します
  #
  # IDで指定されたユーザーの情報を取得します
  #
  # @param <int> id 情報を取得したいユーザーのID
  # @param <string> format レスポンス形式(json, html)
  #
  # @response json
  #   {
  #     "id": 1,
  #     "name": "rosylilly",
  #     "created_at": "2012-05-01 12:00:00"
  #   }
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # ユーザーの新規作成画面を表示します
  #
  # @deprecated すべてAPIのみで挙動するようになるため、この機能は今後廃止されます
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # ユーザーの情報編集画面を表示します
  #
  # @deprecated すべてAPIのみで挙動するようになるため、この機能は今後廃止されます
  def edit
    @user = User.find(params[:id])
  end

  # あたらしくユーザーを作成します
  #
  # @param <hash> user ユーザーの情報
  # @param <string> format レスポンス形式(json, html)
  # @option user <string> name ユーザー名
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # ユーザー情報の変更をおこないます
  #
  # @param <int> id 変更するユーザーのID
  # @param <hash> user 更新するユーザー情報
  # @option user <string> name ユーザー名
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # ユーザーを削除します
  #
  # @param <int> id 削除するユーザーのID
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
