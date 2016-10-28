module Billings
  class CreateCustomerService < BaseService

    def initialize(account:)
      @account = account
    end

    def execute
      Billings::BaseService::Customer.create(
        description: "#{account.name} (#{account.subdomain}.keygen.sh)",
        email: account.admins.first.email
      )
    rescue Billings::BaseService::Error
      nil
    end

    private

    attr_reader :account
  end
end
