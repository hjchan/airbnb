class AdminController < Clearance::SessionsController

  before_action :check_admin

  def show

  end

  def verify
    @listings = Listing.where(verify: false)
  end

  def confirm
    @listing = Listing.find(params[:id])
    @listing.verify = true
    @listing.save
    redirect_to admin_verify_path
  end

  private

  def check_admin
    unless signed_in? && (current_user.admin? == true)
      flash[:notice] = "You are not an admin"
      redirect_to root_path
    end
  end

end
