class ContactsController < ApplicationController
  def index
    contacts = Contact.all
    if params[:search]
      contacts = contacts.where("first_name ILIKE ?" , "%#{params[:search]}%")
    render json: contacts.as_json
  end
  def show
    contact_id = params["id"]
    contact = Contact.find_by(id:  contact_id)
    render json: contact.as_json
  end 
  def create
    contact = Contact.new(
    first_name: params["first_name"],
    middle_name: params["middle_name"],
    last_name:  params["last_name"],
    bio: params["bio"],
    email: params["email"],
    phone_number: params["phone_number"])
    contact.save
    render json: contact.as_json
  end
  def update
    contact_id = paramns["id"]
    contact = Contact.find_by(id: contact_id)
    contact.first_name = params["first_name"] || contact.first_name
    contact.middle_name = params ["middle_name"] || contact.middle_name
    contact.last_name = params["last_name"] || contact.last_name
    contact.bio = params["bio"] || contact.bio
    contact.email = params["email"] || contact.email
    contact.phone_number = params["phone_number"] || contact.phone_number
    contact.save
    render json: contact.as_json
  end
  def destroy
    contact_id = params["id"]
    contact = Contact.find_by(id: contact_id)
    contact.destroy 
    render json: {message: "Contact successfully removed!!"}
  end
end 
