class OrderMailer < ApplicationMailer
  def confirmation
    @order = Order.find params[:order_id]
    order_params = @order.json_for_webhook
    @hostname = @order.client.delivery_fields.first['values'][order_params['host'].to_s]

    mail(to: order_params['email'], subject: 'Votre commande d\'abonnements de ski')
  end

  def admin
    @order = Order.find params[:order_id]
    attachments['order.json'] = {
      mime_type: 'application/json',
      content: @order.json_for_webhook.to_json
    }

    mail(to: 'guy.minder@jpmguides.com', cc: 'neville.dubuis@jpmguides.com', subject: 'Shopping Cart | Nouvelle commande - Webhook non atteignable')
  end

  def repost
    @order = Order.find params[:order_id]
    attachments['order.json'] = {
      mime_type: 'application/json',
      content: @order.json_for_webhook.to_json
    }

    mail(to: 'guy.minder@jpmguides.com', cc: 'neville.dubuis@jpmguides.com', subject: 'Shopping Cart | Commande(s) repostée(s)', body: params[:orders_id].join(','))
  end
end
