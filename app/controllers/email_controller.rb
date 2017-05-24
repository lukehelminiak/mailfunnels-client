class EmailController < ShopifyApp::AuthenticatedController
	before_action :set_list_id, only: [:emails]
	before_action :set_email_list, only: [:editlist, :updatelist, :destroylist]
	protect_from_forgery with: :null_session


  # Page Render Function
  # --------------------
  # Renders the Email Lists Page which displays
  # card view of all Email Lists
  #
	def lists

		@app  = MailfunnelsUtil.get_app
		@list = EmailList.where(app_id: @app.id)

  end


  # Page Render Function
  # --------------------
  # Renders the All Email Templates Page
  # which displays card view of all the email
  # templates for the app
  #
  def email_templates

    # Get the Current App
    @app = MailfunnelsUtil.get_app

    # Get all Email Templates For the App
    @templates = EmailTemplate.where(app_id: @app.id)

  end


  # USED WITH AJAX
  # Creates a new EmailTemplate Instance
  #
  # PARAMETERS
  # ----------
  # app_id: ID of the current app being used
  # name: Name of the EmailTemplate
  # description: description of the EmailTemplate
  # email_subject: Email Subject of the EmailTemplate
  # email_content: Email Content of the EmailTemplate
  #
  def ajax_create_email_template

    # Create a new EmailTemplate Instance
    template = EmailTemplate.new

    # Update the attributes of the EmailTemplate
    template.app_id = params[:app_id]
    template.name = params[:name]
    template.description = params[:description]
    template.email_subject = params[:email_subject]
    template.email_content = params[:email_content]



    # Save and verify Funnel and return correct JSON response
    if template.save!
      final_json = JSON.pretty_generate(result = {
          :success => true
      })
    else
      final_json = JSON.pretty_generate(result = {
          :success => false
      })
    end

    # Return JSON response
    render json: final_json
  end



  # Page Render Function
  # --------------------
  # Renders the view template page
  #
  #
  # PARAMETERS
  # ----------
  # template_id: ID of the EmailTemplate we are viewing
  #
  def view_email_template

    # Get the Current App
    @app = MailfunnelsUtil.get_app

    # Get the EmailTemplate We want to View
    @template = EmailTemplate.find(params[:template_id])



  end




	private
	# Use callbacks to share common setup or constraints between actions.
	def set_list_id
		@list = EmailList.find(params[:list_id])
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_email_list
		@email_list = EmailList.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def email_list_params
		params.require(:email_list).permit(:name, :description, :app_id)
	end
end