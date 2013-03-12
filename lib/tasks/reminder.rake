namespace :reminder do
  desc "Send reminders"
  task :send => :environment do
    SwapItem.all.each do |swap_item|
      if swap_item.acceptance.nil?
        PersonMailer.swap_offer(swap_item, nil).deliver
      end      
    end
  end
end
