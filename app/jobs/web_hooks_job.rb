class WebHooksJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts args.inspect
    # Do something later
  end
end
