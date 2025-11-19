
class ApplicationController < ActionController::Base


  def after_sign_out_path_for(resource_or_scope)
    posts_path 
  end
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private

end