class PagesController < ApplicationController

	def index #this is created so that name.com/pages doesn't return empty
		list
		render('list')
	end

	def list
		@pages = Page.order("pages.position ASC") #retrieves records from db in specific order and returns only the column 'position'
	end

	def show
		@page = Page.find(params[:id]) #retrieves the page we are looking for based on the id in the URL
	end

	def new
		@page = Page.new(:name => 'default name', :position => 'please choose a position')
	end

	def create
		@page = Page.new(params[:page])

		if @page.save 
			redirect_to(:action => 'list')
		else
			render('new')
		end
	end

end
