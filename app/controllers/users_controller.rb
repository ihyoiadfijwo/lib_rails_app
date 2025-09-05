class UsersController < ApplicationController
  def login
    if session[:user_id]
      redirect_to books_path
      return
    end

    if request.post?
      user = User.find_by(student_no: params[:student_no])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to books_path, status: :see_other, notice: "ログインに成功しました。"
      else
        flash.now[:alert] = "学籍番号、またはパスワードが正しくありません。"
        render :login, status: :unprocessable_entity
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, notice: "ログアウトしました。"
  end
end