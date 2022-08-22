# frozen_string_literal: true

require './config/boot'
require './config/environment'
require 'clockwork'

module Clockwork
  every(1.minute, 'delete.story') do
    Story.where('created_at >= ?', 2.minutes.ago.utc).destroy
  end
end
