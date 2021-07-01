module Session
  def self.create(user)
    token = SecureRandom.hex(64)
    Redis.mapped_hmset(
      token,
      'user_id' => user.id
    )
    Redis.expire(token,Settings.session.timeout)
  end
end
