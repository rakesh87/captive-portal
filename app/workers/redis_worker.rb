class RedisWorker
  include Sidekiq::Worker
  sidekiq_options :backtrace => 5, :retry => false

  def perform(visitor_batch)

    unless Rails.env == "development"
      redis = Redis.new(:host => '10.225.132.32', :port => 6379)
    else
      redis = Redis.new(:host => 'localhost', :port => 6379)
    end

    puts "running...."
    redis_insert_start_time = Time.now
    redis_hash_data ={}
    visitor_batch.each do |hash_data|
      bucket_id = hash_data['mac_id'].gsub(':', '')[-6,6]
      #bucket_id = Digest::SHA1.hexdigest(hash_data['mac_id'])[0, 4]
      if redis_hash_data["1:#{bucket_id}"]
        redis_hash_data["1:#{bucket_id}"] += [hash_data['mac_id'], {"n" => hash_data['name'], "eid" => hash_data['email']}.to_json]
      else
        redis_hash_data["1:#{bucket_id}"] = [hash_data['mac_id'], {"n" => hash_data['name'], "eid" => hash_data['email']}.to_json]
      end
    end

    redis_hash_data.each do |k, v|
      redis.hmset(k, v)
    end

    puts "********************** Total time to execute redis query #{Time.now - redis_insert_start_time} seconds**********"
  end
end
