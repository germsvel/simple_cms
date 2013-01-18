class SubjectsController < ApplicationController

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
	end

	def create
		#Instantiate a new object using form parameters
		@subject = Subject.new(params[:subject])
		#Save the object
		if @subject.save   #recall .save returns a boolean
			#If save succeeds, redireect to list action
			redirect_to(:action => 'list')
		else
			#If save fails, redisplay the form so user can fix problems
			render('new')
			#note that here we need to tell render how to pre-populate the form. We want it to be pre-populated 
			#with information that the user had already put in. Fortunately, defining @subject as an instance 
			#variable makes it so that when render('new') is looking for parameters to to use, form_for uses those of 
			#@subject. 
		end
	end

end
