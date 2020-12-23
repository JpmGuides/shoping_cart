class ApplicationMailer < ActionMailer::Base
  default from: 'finances@arolla.com'
  layout 'mailer'

  def confirmation
    @order = params[:order]
    order_params = @order.json_for_webhook
    @hostname = @order.client.delivery_fields.first['values'][order_params['host'].to_s]

    mail(to: params['email'], subject: 'Votre commande d\'abonnements de ski')
  end

  def admin
    @order = params[:order]
    attachments['filename.jpg'] = {
      mime_type: 'application/json',
      content: @order.json_for_webhook.to_json
    }

    mail(to: 'guy.minder@jpmguides.com', subject: 'Nouelle commande d\'abonnements de ski')
  end
end
