class DemoController < ApplicationController
  
  def index
  	#render('index')
  	#redirect_to(:action => 'other_hello')
  end

  def hello
  	@array = [1,2,3,4,5]
  	@id = params[:id]
  	@page = params[:page].to_i
  end

  def other_hello
  	render(:text =>'this is another hello')
  end

end