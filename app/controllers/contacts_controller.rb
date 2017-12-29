class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_all
    Contact.delete_all if params["message"] == "delete"
    redirect_to request.referrer
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_all
    send_data Contact.to_csv, filename: "#{DateTime.now}-#{Contact.count}-emails_check.csv"
  end

  def check_emails
    if (params["message"].split("\n\r").length > 1)
      params["message"].split("\n\r").each do |email|
        Contact.find_by(email: email) || Contact.create(email: email)
      end
    elsif (params["message"].split("\r\n").length > 1)
      params["message"].split("\r\n").each do |email|
        Contact.find_by(email: email) || Contact.create(email: email)
      end
    elsif (params["message"].split("\n").length > 1)
      params["message"].split("\n").each do |email|
        Contact.find_by(email: email) || Contact.create(email: email)
      end
    elsif (params["message"].split("\r").length > 1)
      params["message"].split("\r").each do |email|
        Contact.find_by(email: email) || Contact.create(email: email)
      end
    else
      Contact.find_by(email: params["message"])
    end
    redirect_to request.referrer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:email, :is_valid)
    end
end
