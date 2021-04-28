namespace :orders do
  desc "Repost accepted order that have not been confirmed by remote handler"
  task repost: :environment do
    not_posted_orders = Order.where('status = ? AND request_received_reference IS NULL', 'accepted')

    if not_posted_orders.exists?
      not_posted_orders.each do |order|
        order.post_to_webhook
      end

      OrderMailer.with(orders_id: not_posted_orders.pluck(&:id)).repost.deliver_now
    end
  end
end
