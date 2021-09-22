namespace :orders do
  desc "Repost accepted order that have not been confirmed by remote handler (if client auto_repost_orders is set to true)"
  task repost: :environment do
    Client.where(auto_repost_orders: true).find_each do |client|
      not_posted_orders = client.orders.where('status = ? AND request_received_reference IS NULL', 'accepted')

      if not_posted_orders.exists?
        not_posted_orders.each do |order|
          order.post_to_webhook

          OrderMailer.with(order_id: order.id).repost.deliver_now
        end
      end
    end
  end
end
