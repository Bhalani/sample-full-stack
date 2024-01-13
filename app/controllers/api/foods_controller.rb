class Api::FoodsController < Api::ApiController
  before_action :authenticate_user!

  def index
    @foods = Food.all
  end

  def create
    food = Food.new(food_params)

    if food.save
      render json: food.to_json
    else
      render json: food.errors.to_json, status: :unprocessable_entity
    end
  end

  private

  def food_params
    params.require(:params).permit(:name, :calories)
  end
end
