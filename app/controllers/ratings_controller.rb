class RatingsController < ApplicationController

  def update
    @rating     = Rating.unscoped.find params[:id]
    @submission = @rating.submission

    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end

end
