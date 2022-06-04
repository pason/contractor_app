shared_context 'sneakers_publish_inline' do
  let(:sneakers_worker_classes) do
    # Load all worker classes (adjust if not Rails).
    Dir[Rails.root.join('app', 'workers', '**', '*.rb')].each { |f| require f }
    ObjectSpace.each_object(Class).select { |c| c.included_modules.include? Sneakers::Worker }
  end

  before do
    allow_any_instance_of(Sneakers::Publisher).to receive(:publish) do |_obj, msg, opts|
      queue = opts[:to_queue]
      worker_class = sneakers_worker_classes.find { |w| w.queue_name == queue }
      raise ArgumentError, "Cannot find Sneakers worker class for queue: #{queue}" unless worker_class
      worker_class.new.work(msg)
    end
  end
end