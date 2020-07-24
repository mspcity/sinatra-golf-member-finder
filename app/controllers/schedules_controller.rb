class SchedulesController < ApplicationController

  get '/schedules/new' do
    erb :'schedules/new'
  end

  get '/schedules' do
    if !(Helpers.is_logged_in?(session))
      redirect to 'login'
    end

    @schedules = Schedule.all

    erb :'schdules/index'
  end

  post '/schedules' do
    if params[:date].blank? || params[:booking_time].blank? || params[:number_of_holes].blank? || params[:course].blank? || params[:phone].blank? || params[:email].blank? ||params[:note].blank?
      erb :'/errors/blank_error'
    else

      @schedules = Schedule.create(date: params[:date], booking_time: params[:booking_time], number_of_holes: params[:number_of_holes], course: params[:course], phone: params[:phone], email: params[:email], note: params[:note], user_id: Helpers.current_user(session).id)
      redirect to '/schedules'
    end
  end

  get '/schedules/:id' do
    if Helpers.is_logged_in?(session)
      @schedule = Schedule.find_by_id(params[:id])
      if @schedule
        erb :'schedules/show'
      else
        redirect to '/schedules'
      end
    else
      redirect to '/login'
    end
  end




end