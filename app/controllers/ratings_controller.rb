class RatingsController < ApplicationController

  def update
    @rating     = Rating.find(params[:id])
    @submission = @rating.submission

    puts "SENT SCORE: #{params[:score]}"

    if @rating.update_attributes(score: params[:score])
      @rating.reload
      puts "RELOADED WITH: #{@rating.score}"
      respond_to do |format|
        format.js
      end
    end
  end

end
