# frozen_string_literal: true

require "rails_helper"

RSpec.describe Payment, type: :model do
  it { should belong_to :reservation }
end
