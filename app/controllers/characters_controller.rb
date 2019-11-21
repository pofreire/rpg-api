class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :update, :destroy]

  # GET /characters
  def index
    @characters = Character.filter_name(params[:name])
                           .filter_gt(params[:str_gt])
                           .filter_lt(params[:str_lt])

    #@characters = Character.where("name like ? or created_at like ?", "%#{params[:name]}%", "%#{params[:name]}%  ")

    render json: @characters.to_json({include: [skills: {:except => [:character_id, :created_at, :updated_at],
                                                          :methods => [:score]
                                                        }],
                                      :except => [:created_at, :updated_at],
                                      :methods => [:level, :life, :proficient]})
  end


  # GET /characters/1
  def show
    render json: @character.to_json({include: [skills: {:except => [:character_id, :created_at, :updated_at],
                                                         :methods => [:score]
    }],
                                      :except => [:created_at, :updated_at],
                                      :methods => [:level, :life, :proficient]})
  end

  # POST /characters
  def create
    @character = Character.new(character_params)

    if @character.save
      render json: @character, status: :created, location: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /characters/1
  def update
    if @character.update(character_params)
      render json: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # DELETE /characters/1
  def destroy
    @character.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def character_params
      params.require(:character).permit(:name, :life, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma)
    end
end
