module Eventable
  extend ActiveSupport::Concern

  included do
    after_initialize do
      self.event_type = event_type
      self.payload ||= {}
    end
  end

  def event_type
    self.class.to_s.split('::').last
  end
end