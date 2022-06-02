desc 'Run all of sneakers tasks'
task amqp: :environment do
  PaymentRequestCreatedWorker
  Rake::Task['sneakers:run'].invoke
end
