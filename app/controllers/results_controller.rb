class ResultsController < ApplicationController
  caches_page :show, :index, :schools
  def index
    @results = Result.all.order('name DESC')
    @recents = Result.all.order('created_at DESC').first(5) if stale?(@results)
  end

  def show
    @result = Result.find_by_name(params[:name])
    @i = SciolyFF::Interpreter.new(@result.data) if stale?(@result)
  end

  def new
    @result = Result.new
  end

  def create
    @result = Result.new(result_params)
    if @result.save
      cache_page action: "index"
      cache_page action: "schools"
      redirect_to "/results/#{@result.name}"
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
    @name = @result.name
    if @result.update(result_params)
      expire_page action: "show", name: @name
      expire_page action: "index"
      expire_page action: "schools"
      redirect_to name: Result.find(@id).name
    else
      render :edit
    end
  end

  def destroy
    @result = Result.find_by_name(params[:name])
    expire_page action: "show", name: @result.name
    @result.destroy
    redirect_to root_url
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
