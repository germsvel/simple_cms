class PagesController < ApplicationController

	layout 'admin'

	before_filter :confirm_logged_in
	before_filter :find_subject

	def index #this is created so that name.com/pages doesn't return empty
		list
		render('list')
	end

	def list
		@pages = Page.sorted.where(:subject_id => @subject.id) #retrieves records from db in specific order and returns only the column 'position'
	end

	def show
		@page = Page.find(params[:id])
	end

	def new
		@page = Page.new(:subject_id => @subject.id)
		@page_count = @subject.pages.size + 1
		@subject_ids = Subject.pluck(:id)
	end

	def create
		@page = Page.new(params[:page])

		if @page.save 
			flash[:notice] = "Page created!"
			redirect_to(:action => 'list', :subject_id => @page.subject_id)
		else
			@page_count = @subject.pages.size + 1
			@subject_ids = Subject.pluck(:id)
			render('new')
		end
	end

	def edit
		@page = Page.find(params[:id])
		@page_count = @subject.pages.size
		@subject_ids = Subject.pluck(:id)
	end

	def update
		@page = Page.find(params[:id])

		if @page.update_attributes(params[:page])
			flash[:notice] = "Page updated!"
			redirect_to(:action => 'show', :id => @page.id, :subject_id => @page.subject_id)
		else
			@page_count = @subject.pages.size
			@subject_ids = Subject.pluck(:id)
			render('edit')
		end
	end

	def delete
		@page = Page.find(params[:id])
	end

	def destroy
		Page.find(params[:id]).destroy
		flash[:notice] = "Page deleted!"
		redirect_to(:action => 'list', :subject_id => @subject.id)
	end

	private

	def find_subject
		if params[:subject_id]
			@subject = Subject.find_by_id(params[:subject_id])
		end
	end

end
