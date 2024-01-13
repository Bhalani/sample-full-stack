class Api::Admin::CaloriesController < Api::Admin::AdminController
  before_action :authenticate_user!

  before_action :get_user_calorie
  def index
    @user_calories = UserCalory.where(clause).includes(:food).order(consume_at: :desc).page(params[:page] || 1).per(10)
  end

  def exceeded_calories
    @users = User.where(role: "user").group_by(&:id)
    @exceeded_calories_per_day = UserCalory.where(is_cheat_food: false)
                                           .joins(:user)
                                           .group("DATE(consume_at), user_id, users.daily_calorie_limit")
                                           .select("SUM(calories) as total_calories, DATE(consume_at) as consume_date, user_id, daily_calorie_limit as limit")
                                           .having("SUM(calories) >= users.daily_calorie_limit")
                                           .order("DATE(consume_at) desc")
  end

  def create
    food_param = {}
    if params[:user_calories][:custom_food].present?
      food = Food.create(name: params[:user_calories][:custom_food], calories: calories_params[:calories])
      food_param[:food_id] = food.id
    end

    @user_calory = UserCalory.new(calories_params.merge(food_param))

    if @user_calory.save
      render :show
    else
      render json: { error: user_calory.errors.to_json }, status: :unprocessable_entity
    end
  end

  def update
    @user_calory.update(update_calories_params)

    render :show
  end

  def destroy
    @user_calory.destroy
  end

  private

  def clause
    return { consume_at: params[:start_date].to_date..params[:end_date].to_date } if params[:start_date]

    {}
  end

  def calories_params
    params.require(:user_calories).permit(:food_id, :consume_at, :calories, :user_id)
  end

  def update_calories_params
    params.require(:user_calories).permit(:is_cheat_food)
  end

  def get_user_calorie
    @user_calory = UserCalory.find_by(id: params[:id])
  end
end
