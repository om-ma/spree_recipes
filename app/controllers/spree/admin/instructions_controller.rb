module Spree
  module Admin
    class InstructionsController < ResourceController

      private

      def scope
        Spree::Instruction.all
      end

      def find_resource
        scope.find(params[:id])
      end

      def collection
        return @collection if @collection.present?

        params[:q] ||= {}
        @collection = scope

        @search = @collection.ransack(params[:q])
        @collection = @search.result.order(:created_at).page(params[:page]).per(params[:per_page])
      end
    end
  end
end
