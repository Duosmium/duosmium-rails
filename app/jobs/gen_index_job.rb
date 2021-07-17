class GenIndexJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    rc = ResultsController.new
    rc.expire_page controller: "results", action: "index"
    # rc.cache_page controller: "results", action: "index"
    # rc.cache_page controller: "results", action: "schools"
  end
end
