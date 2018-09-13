require 'spec_helper'

class User
  include ActiveModel::Model
  include Fluent::Validation

  mandatories :first_name, 
              :last_name, 
              :username,
              { email:      { format: { with: URI::MailTo::EMAIL_REGEXP }}},
              { contact_no: { numericality: true, format: { with: /\d+/ }}}

  optionals gender: { inclusion: { in: ['M', 'F'] }}
end

describe Fluent::Validation do
  it 'has a version number' do
    expect(Fluent::Validation::VERSION).not_to be nil
  end

  describe User do
    it { expect(User.validators.size).to eq(9) }

    it { expect(User.validators_on(:first_name).size).to eq(1) }
    it { expect(User.validators_on(:last_name).size).to eq(1) }

    it { expect(User.validators_on(:username).size).to eq(1) }
    it { expect(User.validators_on(:email).size).to eq(2) }
    it { expect(User.validators_on(:contact_no).size).to eq(3) }

    it { expect(User.validators_on(:gender).size).to eq(1) }
  end
end
