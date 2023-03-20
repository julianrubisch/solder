module Solder
  class UiStateController < ApplicationController
    include ActionView::Helpers::SanitizeHelper

    before_action :set_ui_state, only: :show
    around_action Solder.config[:around_action]

    def show
      render json: @ui_state.to_json
    end

    def update
      Rails.cache.write "solder/#{ui_state_params[:key]}", parsed_attributes
      records_to_touch.map(&:touch)

      head :ok
    end

    private

    def ui_state_params
      params.permit(:attributes, :key)
    end

    def set_ui_state
      @ui_state = Rails.cache.read "solder/#{ui_state_params[:key]}"
    end

    def records_to_touch
      GlobalID::Locator.locate_many_signed parsed_attributes["data-solder-touch"]&.split(":") || []
    end

    def parsed_attributes
      JSON.parse(ui_state_params[:attributes]).deep_transform_values { sanitize(_1) }
    end
  end
end
