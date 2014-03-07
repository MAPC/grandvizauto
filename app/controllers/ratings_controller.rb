class RatingsController < ApplicationController

  def create
    @rating = Rating.new(params[:rating])
    @submission = @rating.submission

    if @rating.save
      respond_to do |format|
        format.js {render 'ratings/create'}
      end
    end
  end

  def update
    @rating     = Rating.find(params[:id])
    @submission = @rating.submission

    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js {render 'ratings/create'}
      end
    end
  end

end
