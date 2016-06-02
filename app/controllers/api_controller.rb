class ApiController < ApplicationController
  before_action :ensure_api_token_is_valid

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { ok: false, errors: e.record.errors, status: 'error saving' }
  end

  def status
    users = Array(params[:users]).select(&:present?)

    if users.blank?
      return render_error('must provide an array of users')
    end

    return_arr = {}.tap do |h|
      users.each do |u|
        h[u] = if (checkin= Checkin.most_recent_for_user(u))
                 {
                   location: checkin.location.name || 'Unknown location',
                   created_at: checkin.created_at
                 }
               end
      end
    end

    render json: return_arr
  end

  def checkin
    checkin = Checkin.create!(
      location: Location.find_or_create_by!(mac_address: params[:mac_address]),
      user: params[:user]
    )

    render_ok(
      if checkin.location.name.present?
        "You are... #{checkin.location.name}"
      else
        'You are in an unknown location.'
      end
    )
  end

  def update_location_name_by_user
    current_checkin = Checkin.most_recent_for_user(params[:user])

    if !current_checkin
      return render_error("can't find recent checkin for user")
    end

    if current_checkin.created_at < 10.minutes.ago
      return render_error("user hasn't checked in recently")
    end

    unless params[:name].present?
      return render_error('please provide a name for this location')
    end

    current_checkin.location.update!(name: params[:name])

    render_ok
  end

  private

  def ensure_api_token_is_valid
    unless ENV['API_TOKEN'] && (params[:token] == ENV['API_TOKEN'])
      render json: { ok: false, status: 'not authorized' },
             status: :unauthorized
    end
  end

  def render_error(msg)
    render json: { ok: false, status: msg }, status: :bad_request
  end

  def render_ok(status = nil)
    hash = { ok: true }
    hash[:status] = status if status.present?
    render json: hash
  end
end
