class ApplicationController < ActionController::Base

  # ONLY FOR DEVELOPMENT/TEST PURPOSES
  skip_before_action :verify_authenticity_token

  protected

  def authenticate
    begin
      unless current_user
        render json: {error: flash[:signin_error]}, status: 401
      end
      data = payload(current_user)

      if data.nil? || data[:auth_token].nil?
        head :unauthorized and return
      end

      if request.method != 'HEAD'
        puts "---------REFRESH TOKEN : #{data[:auth_token]}----------------" if Rails.env.development?
        headers['Authorization'] = data[:auth_token]
        headers['Ttl'] = 14.days.since.to_i
        headers['UserId'] = current_user.id
      end

    rescue JWT::VerificationError, JWT::DecodeError
      render json: {error: flash[:signin_error]}, status: 401
    end
  end


  private
  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token, 'coinhouse_reservation')
  end

  def user_id_in_http_token?
    auth_token && auth_token[:user_id].to_i
  end

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id, exp: 14.days.since.to_i}, 'coinhouse_reservation'),
      user: {id: user.id, email: user.email}
    }
  end

  def current_user
    unless user_id_in_http_token?
      return nil
    end
    @_current_user = User.find(auth_token[:user_id])
    @_current_user
  end
end
