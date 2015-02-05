class SubscriptionsController < ApplicationController
  def new
    if params[:email]
      @email = params[:email]
    end
  end

  def create
    # Amount in cents
    @amount = 9900

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      card: params[:stripeToken],
      description: '$99/month PlanningAlerts subscription'
    )

  # TODO: rescue and redirect to new on attempt to reload the create page
  # which tries to reuse the token again and errors.
  # Also redirect someone trying to load /subscriptions to #new as well

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
  end
end
