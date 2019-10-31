class SessionsController < ApplicationController

  def new
  end

  # ログイン機能
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # userとuser.authenticateが共に真の場合にtrue
    # 入力されたメールアドレスを持つユーザーがデータベースに存在し、かつ入力されたパスワードがそのユーザーのパスワードである場合のみtrueになる。
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user_path(user)

    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
