# frozen_string_literal: true

module Api::V1
  class ProfilesController < Api::V1::BaseController
    before_action :scope_to_current_account!
    before_action :require_active_subscription!
    before_action :authenticate_with_token!

    # GET /profile
    def show
      authorize current_bearer

      render jsonapi: current_bearer, meta: { tokenId: current_token&.id }
    end
  end
end
