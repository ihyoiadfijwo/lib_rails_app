class BooksController < ApplicationController
  before_action :authenticate_user!, :set_book, only: %i[ show edit update destroy borrow return_book]
  protect_from_forgery except: :index

  # GET /books or /books.json
  def index
    @categories = Book.distinct.pluck(:category)

    if params[:q].present? || params[:category].present?
      query = params[:q]
      category = params[:category]

      @books = Book.where("title LIKE :query OR author LIKE :query", query: "%#{query}%")
      @books = @books.where(category: category) if category.present?
    else
      @books = Book.all
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /books/1 or /books/1.json
  def show
    @book = Book.find(params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books/:id/borrow
  def borrow
    loan = @book.loans.new(user: current_user, borrowed_at: Date.today, due_at: Date.today + 7.days)
    if loan.save
      redirect_to @book, notice: "本を借りました。返却期限は#{loan.due_at}です。"
    else
      redirect_to @book, alert: "本を借りることができませんでした。"
    end
  end

  # DELETE /books/:id/return
  def return_book
    loan = @book.loans.find_by(user: current_user)
    if loan
      loan.destroy
      redirect_to @book, notice: "本を返却しました。"
    else
      redirect_to @book, alert: "返却する本が見つかりませんでした。"
    end
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_path, status: :see_other, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :isbn, :category, :total_copies)
    end
end
