class SubjectsController < ApplicationController

	layout 'admin'

	before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]

	def index #we create this b/c we don't want a user who goes to the URL name.com/subjects to find an error, so we choose here what to display
		list  # we will display the list (method below)
		render('list') #must put which template to render or it will try to render index by default
	end

	def list
		@subjects = Subject.order("subjects.position ASC")
	end

	def show
		@subject = Subject.find(params[:id])
		#note that params[:id] retrieves the id from the URL
	end

	def new
		@subject = Subject.new(:name => 'default')
		@subject_count = Subject.count + 1
	end

	def create
		#Instantiate a new object using form parameters
		@subject = Subject.new(params[:subject])
		#Save the object
		if @subject.save   #recall .save returns a boolean
			#If save succeeds, redireect to list action
			flash[:notice] = "Subject created."
			redirect_to(:action => 'list')
		else
			#If save fails, redisplay the form so user can fix problems
			@subject_count = Subject.count + 1
			render('new')
			#note that here we need to tell render how to pre-populate the form. We want it to be pre-populated 
			#with information that the user had already put in. Fortunately, defining @subject as an instance 
			#variable makes it so that when render('new') is looking for parameters to to use, form_for uses those of 
			#@subject. 
		end
	end

	def edit
		@subject = Subject.find(params[:id])
		@subject_count = Subject.count
	end

	def update
		#Find a new object using form parameters
		@subject = Subject.find(params[:id])
		#Update the object
		if @subject.update_attributes(params[:subject])  
			#If update succeeds, redireect to list action
			flash[:notice] = "Subject updated."
			redirect_to(:action => 'show', :id => @subject.id)
		else
			#If update fails, redisplay the form so user can fix problems
			@subject_count = Subject.count
			render('edit')
		end	
	end

	def delete
		@subject = Subject.find(params[:id])
	end

	def destroy
		Subject.find(params[:id]).destroy
		flash[:notice] = "Subject destroyed."
		redirect_to(:action => 'list')
	end

end
