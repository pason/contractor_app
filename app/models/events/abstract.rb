module Events
  class Abstract < ApplicationRecord
    self.abstract_class = true

    after_initialize do
      self.event_type = event_type
      self.payload ||= {}
    end

    def event_type
      self.class.to_s.split('::').last
    end
  end
end
