class ResultsController < ApplicationController
  def index
    @results = Result.all.order('name DESC')
    if stale?(@results)
      @recents = Result.all.order('created_at DESC').first(5)
    end
  end

  def show
    @result = Result.find_by_name(params[:name])
    if stale?(@result)
      @i = SciolyFF::Interpreter.new(@result.data)
    end
  end

  def new
    @result = Result.new
  end

  def create
    @result = Result.new(result_params)
    if @result.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @result = Result.find_by_name(params[:name])
  end

  def update
    @result = Result.find_by_name(params[:name])
    @id = @result.id
    if @result.update(result_params)
      redirect_to name: Result.find(@id).name
    else
      render :edit
    end
  end

  def destroy
    @result = Result.find_by_name(params[:name])
    @result.destroy

    redirect_to result_url
  end

  def schools
    @results = Result.all
  end

  def download
    send_data Result.find_by_name(params[:name].gsub('.yaml', '')).data,
              filename: "#{params[:name]}.yaml",
              type: 'application/x-yaml'
  end

  private

  def result_params
    params.require(:result).permit(:name, :data)
  end
end
