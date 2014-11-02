class PokemonsController < ApplicationController

  def new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.update_attributes(:trainer_id => current_trainer.id, :level => 1, :health => 100)
    if @pokemon.save
      redirect_to(trainer_path(id: current_trainer.id))
    else
      flash[:error] = @pokemon.errors.full_messages.to_sentence
      redirect_to(trainer_path(id: current_trainer.id))
    end
  end


  def capture
    @pokemon = Pokemon.find(params[:id])
    pokemon_id = @pokemon.id
    @pokemon.update_attributes(:trainer_id => current_trainer.id)
    @pokemon.save
    redirect_to(:back)
  end

  def heal
    @pokemon = Pokemon.find(params[:id])
    if @pokemon.health <= 100
      @pokemon.health += 10
    end
    @pokemon.save
    redirect_to(:back)
  end

  def damage
    @pokemon = Pokemon.find(params[:id])
    @pokemon.health -= 10
    @pokemon.save
    redirect_to(:back) 
  end

  def destroy(pokemon)
    pokemon.destroy
  end


  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :trainer_id, :level, :health)
  end

end
