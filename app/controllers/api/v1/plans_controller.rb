module Api::V1
  class PlansController < Api::V1::BaseController
    before_action :set_plan, only: [:show]

    # GET /plans
    def index
      @plans = apply_scopes(Plan).all

      authorize @plans

      render jsonapi: @plans
    end

    # GET /plans/1
    def show
      authorize @plan

      render jsonapi: @plan
    end

    private

    def set_plan
      @plan = Plan.find params[:id]
    end
  end
end
