require 'spec_helper'

describe Request do
  let(:request) { create :request }

  describe 'Validations' do
    it { should validate_presence_of :title }

    it { should validate_uniqueness_of :title }
  end
end
