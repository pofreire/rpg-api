module Api::V1
  class SkillsController < ApplicationController
    before_action :set_skill, only: [:show, :update, :destroy]

    # GET /skills
    def index
      @skills = Skill.find_all_by_character_id(params[:character_id])

      render json: @skills.to_json(:only => [:id, :ability, :name])
    end

    # GET /skills/1
    def show
      render json: @skill
    end

    # POST /skills
    def create
      @skill = Skill.new(skill_params)

      if @skill.save
        render json: @skill, status: :created
      else
        render json: @skill.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /skills/1
    def update
      if @skill.update(skill_params)
        render json: @skill
      else
        render json: @skill.errors, status: :unprocessable_entity
      end
    end

    # DELETE /skills/1
    def destroy
      @skill.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_skill
        @skill = Skill.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def skill_params
        params.require(:skill).permit(:name, :ability, :proficient, :character_id)
      end
  end
end
