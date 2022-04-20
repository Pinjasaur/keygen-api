# frozen_string_literal: true

module Api::V1::Processes::Relationships
  class MachinesController < Api::V1::BaseController
    before_action :scope_to_current_account!
    before_action :require_active_subscription!
    before_action :authenticate_with_token!
    before_action :set_process

    def show
      machine = @process.machine
      authorize machine

      render jsonapi: machine
    end

    private

    def set_process
      @process = current_account.machine_processes.find(params[:process_id])
      authorize @process, :show?

      Current.resource = @process
    end
  end
end