module Spree
  module Admin
    class InstructionsController < ResourceController
      belongs_to 'spree/recipe', find_by: :slug
      before_action :find_instructions
      before_action :setup_instruction, only: :index

      private

      def find_instructions
        @instruction = Spree::Instruction.pluck(:description)
      end

      def setup_instruction
        @recipe.instructions.build
      end
    end
  end
end
