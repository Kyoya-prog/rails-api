class PatiencesController < ApplicationController
  def create
    user = Session.current_user
    patience = user.patiences.build(patience_params)
    status = :bad_request
    if patience.save
      status = :ok
      render json:{message:"patience has been registered"},status:status
    else
      render json:{error:"error"},status:status
    end
  end

  def update
    patience = Session.current_user.patiences.find_by(id:params[:id])
    status = :bad_request
    if patience.update(patience_params)
      status = :ok
      render json: {message:"patience has been updated"},status:status
    else
      render json: {error:"error"},status:status
    end
  end


  private
    def patience_params
      params.require(:patience).permit(:money,:description,:category_title,:registered_at)
    end
end
