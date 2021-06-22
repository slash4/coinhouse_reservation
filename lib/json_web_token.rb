class JsonWebToken
  def self.encode(payload, app='coinhouse_reservation')
    JWT.encode(payload, Rails.application.secrets.secret_key_base + app)
  end

  def self.decode(token, app='coinhouse_reservation')
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base + app)[0])
  rescue
    nil
  end
end
