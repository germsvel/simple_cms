class SectionsController < ApplicationController

	layout 'admin'
	
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
			flash[:notice] = "Section has been created"
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
			flash[:notice] = "You have updated a section"
			redirect_to(:action => 'show', :id => @section.id)
		else
			render('edit')
		end
	end

	def delete
		@section = Section.find(params[:id])
	end

	def destroy
		Section.find(params[:id]).destroy
		flash[:notice] = "Minus one section. Just deleted it."
		redirect_to(:action => 'list')
	end

end
