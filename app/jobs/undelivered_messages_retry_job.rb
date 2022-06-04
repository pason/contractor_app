class UndeliveredMessagesRetryJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    event = Events::PaymentRequestEvent.find_by!(message_id: message_id)
    event.publish
  end
end