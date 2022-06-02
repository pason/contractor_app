class PaymentRequestCreatedWorker
  include Sneakers::Worker

  from_queue 'contractor_payment_request_created',
             routing_key: 'payment_request.created',
             durable: true

  def work(msg)
    puts "received msg: #{msg.inspect}"
    ack!
  end
end
