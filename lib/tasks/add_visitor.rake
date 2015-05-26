desc "Create Visitors"
task :add_visitors, [:number_integer] => :environment do |t, args|
  visitor_count = Visitor.all.count + 1
  number_of_visitors_to_create = args[:number_integer].to_i + visitor_count
  unless Rails.env == "development"
    redis = Redis.new(:host => '10.181.17.198', :port => 6379)
  else
    redis = Redis.new(:host => 'localhost', :port => 6379)
  end
  while(visitor_count < number_of_visitors_to_create) do
    visitor_name = "visitor_#{visitor_count}"
    visitor_email = "#{visitor_name}@mailinator.com"
    hex_numbers = ['1','2', '3','4','5','6','7','8','9','0','a','b','c','d','e','f']
    mac_id = "#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}"
    puts "**************** Outside : #{mac_id} ******************"
    while Visitor.where(mac_id: mac_id).any?
      mac_id = "#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}"
      puts "**************** Inside : #{mac_id} ******************"
    end
    visitor = Visitor.create(name: visitor_name.humanize, email: visitor_email, mac_id: mac_id)
    unless visitor.mac_id.blank?
      bucket_id = visitor.mac_id.gsub(':', '')[-4,4]
      redis.hset("1:#{bucket_id}", visitor.mac_id, {"name" => visitor_name.humanize, "email" => visitor_email}.to_json)
    end

    puts "************* User is created for Tennat name : #{visitor_name} with email : #{visitor_email} Mac Id: #{mac_id}***************"
    visitor_count += 1
  end
end
