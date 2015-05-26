namespace :db do
  desc "Create Visitors with batch"
  task :visitor_batch_update, [:number_integer] => :environment do |t, args|
          batch = []
          visitor_count = Visitor.count + 1
          no_of_visitores = args[:number_integer].to_i

  # number_of_visitors_to_create = no_of_visitores + visitor_count
  puts "************* #{Time.now} **************"
  while(batch.count < no_of_visitores)
          visitor_name = "v#{visitor_count}"
      visitor_email = "#{visitor_name}@mailinator.com"
      hex_numbers = ['1','2', '3','4','5','6','7','8','9','0','a','b','c','d','e','f']
      #mac_id = "#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}"

      # while true
      # 	if macs.include? mac_id
                  mac_id = "#{hex_numbers.sample(4).sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(2).join}:#{hex_numbers.sample(4).sample(2).join}"
          # 	puts "duplicate"
          # else
          # 	#puts "new"
                  #macs << mac_id
          # 	break
          # end
      # end

      visitor_count += 1
      batch << {name: visitor_name, email: visitor_email, mac_id: mac_id}

  end

  mongo_batch_insert_start_time = Time.now
  batch.each_slice(100000) do |visitor_batch|
          Visitor.with(safe: true).collection.insert(visitor_batch)
          RedisWorker.perform_async(visitor_batch)
          puts "************** #{Time.now} ***********************"
  end
  puts "********************** Total time to execute mongo batch query #{Time.now - mongo_batch_insert_start_time} seconds**********"
  end
end
