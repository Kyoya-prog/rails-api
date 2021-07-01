module Session
  @current_user_token
  def self.get(token)
    @current_user_token = token
    # tokenに紐づいているユーザーIDをハッシュで返す
    REDIS.hgetall(token)
  end

  def self.create(user)
    token = SecureRandom.hex(64)
    REDIS.mapped_hmset(
      token,
      'user_id' => user.id
      )
    REDIS.expire(token,Settings.session.timeout)
    return token
  end

  def self.current_user
    user_id = REDIS.hgetall(@current_user_token)["user_id"]
    User.find(user_id)
  end
end
