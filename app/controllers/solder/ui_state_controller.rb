module Solder
  class UiStateController < ApplicationController
    before_action :set_ui_state, only: :show
    around_action Solder.config[:around_action]

    def show
      render json: @ui_state.to_json
    end

    def update
      Rails.cache.write "solder/#{params[:key]}", JSON.parse(params[:attributes])

      head :ok
    end

    private

    def ui_state_params
      params.permit(:attributes, :key)
    end

    def set_ui_state
      @ui_state = Rails.cache.read "solder/#{params[:key]}"
    end
  end
end
