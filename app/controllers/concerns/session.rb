module Session
  def self.get(token)
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
end
