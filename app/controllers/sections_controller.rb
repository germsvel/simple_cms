class SectionsController < ApplicationController

	def index
		list
		render('list')
	end

	def list
		@sections = Section.order("sections.position ASC")
	end

	def show
		@section = Section.find(params[:id])
	end

	def new
		@section = Section.new(:name => 'Section Name')
	end

	def create
		#instantiate object using form parameters
		@section = Section.new(params[:section])
		#save object
		if @section.save
			#redirect to the list action
			redirect_to(:action => 'list')
		else
			render('new')
		end
	end

	def edit
		@section = Section.find(params[:id])
	end

	def update
		@section = Section.find(params[:id])

		if @section.update_attributes(params[:section])
			redirect_to(:action => 'show', :id => @section.id)
		else
			render('edit')
		end
	end

end
