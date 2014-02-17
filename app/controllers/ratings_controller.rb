class RatingsController < ApplicationController

  def create
    @rating = Rating.new(params[:rating])
    if @rating.save
      respond_to do |format|
        format.js
      end
    end
  end

  def update
    @rating     = Rating.find(params[:id])
    @submission = @rating.submission

    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end

end
