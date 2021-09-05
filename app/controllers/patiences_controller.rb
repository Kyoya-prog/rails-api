require 'time'
require 'date'

class PatiencesController < ApplicationController
  def create
    user = Session.current_user
    patience = user.patiences.build(patience_params)
    status = :bad_request
    if patience.save
      status = :ok
      render json:{message:"patience has been registered",id:patience.id,money:patience.money,
                   memo:patience.memo,category_title:patience.category_title,registered_at:patience.registered_at},status:status
    else
      render json:{error:"error"},status:status
    end
  end

  def update
    patience = Session.current_user.patiences.find_by(id:params[:id])
    status = :bad_request
    if patience.update(patience_params)
      status = :ok
      render json:{message:"patience has been updated",id:patience.id,money:patience.money,
                   memo:patience.memo,category_title:patience.category_title,registered_at:patience.registered_at},status:status
    else
      render json: {error:"error"},status:status
    end
  end

  def destroy
    patience = Session.current_user.patiences.find_by(id:params[:id])
    if patience.destroy
      render json:{message:"patience has been deleted"},status: :ok
    else
      render json: {error:"delete failed"},status: :bad_request
    end
  end

  def per_month
    begin_month = params[:date].in_time_zone.beginning_of_month
    end_month = params[:date].in_time_zone.end_of_month
    logger.info "begin_month: #{begin_month}"
    logger.info "end_month: #{end_month}"
    patiences = Session.current_user.patiences.where(registered_at:begin_month..end_month)
    status = :ok
    render json:{patiences:patiences},status:status
  end

  def per_day
    date = Time.parse(params[:date]).in_time_zone
    logger.info "date: #{date}"
    patiences = Session.current_user.patiences.where(registered_at:date)
    status = :ok
    render json:{patiences:patiences},status:status
  end


  private
  def patience_params
    params.permit(:money,:memo,:category_title,:registered_at,:id)
  end
end

