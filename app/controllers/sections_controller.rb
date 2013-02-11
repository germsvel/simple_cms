class SectionsController < ApplicationController

	layout 'admin'
	
	before_filter :confirm_logged_in
	before_filter :find_page
	
	def index
		list
		render('list')
	end

	def list
		@sections = Section.sorted.where(:page_id => @page.id)
	end

	def show
		@section = Section.find(params[:id])
	end

	def new
		@section = Section.new(:page_id => @page.id)
		@section_count = @page.sections.size + 1
		@page_ids = Page.pluck(:id)
	end

	def create
		new_position = params[:section].delete(:position)
		#instantiate object using form parameters
		@section = Section.new(params[:section])
		#save object
		if @section.save
			#redirect to the list action
			@section.move_to_position(new_position)
			flash[:notice] = "Section has been created"
			redirect_to(sections_path(:page_id => @section.page_id))
		else
			@section_count = @page.sections.size + 1
			@page_ids = Page.pluck(:id)
			render('new')
		end
	end

	def edit
		@section = Section.find(params[:id])
		@section_count = @page.sections.size
		@page_ids = Page.pluck(:id)
	end

	def update
		@section = Section.find(params[:id])
		new_position = params[:section].delete(:position)

		if @section.update_attributes(params[:section])
			@section.move_to_position(new_position)
			flash[:notice] = "You have updated a section"
			redirect_to(section_path(@section.id, :page_id => @section.page_id))
		else
			@section_count = @page.sections.size
			@page_ids = Page.pluck(:id)
			render('edit')
		end
	end

	def delete
		@section = Section.find(params[:id])
	end

	def destroy
		section = Section.find(params[:id])
		section.move_to_position(nil)
		section.destroy
		flash[:notice] = "Minus one section. Just deleted it."
		redirect_to(sections_path(:page_id => @page.id))
	end

	private

	def find_page
		if params[:page_id]
			@page = Page.find_by_id(params[:page_id])
		end
	end

end
