module Amqp
  class OnReturnHandler
    attr_reader :reporter, :performer

    def initialize(performer:)
      @performer = performer
    end

    def call(return_info, properties, content)
      reporter.log('Got returned message', return_info: return_info,
                                                 properties: properties,
                                                 content: content)
      message_id = properties[:message_id]
      performer.set(wait: 5.minutes).perform_later(message_id)
    end

    private

    def reporter
      @reporter ||= Reporting
    end
  end
end