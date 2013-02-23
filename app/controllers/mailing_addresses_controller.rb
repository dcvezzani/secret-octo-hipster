class MailingAddressesController < ApplicationController

  before_filter :load_client
  before_filter :check_load_style
 
  # GET /mailing_addresses
  # GET /mailing_addresses.json
  def index
    @mailing_addresses = MailingAddress.all

    respond_to do |format|
      format.html { render layout: @layout }# index.html.erb
      format.json { render json: @mailing_addresses }
    end
  end

  # GET /mailing_addresses/1
  # GET /mailing_addresses/1.json
  def show
    @mailing_address = MailingAddress.find(params[:id])

    respond_to do |format|
      format.html { render layout: @layout }# show.html.erb
      format.json { render json: @mailing_address }
    end
  end

  # GET /mailing_addresses/new
  # GET /mailing_addresses/new.json
  def new
    @mailing_address = MailingAddress.new

    respond_to do |format|
      format.html { render layout: @layout }# new.html.erb
      format.json { render json: @mailing_address }
    end
  end

  # GET /mailing_addresses/1/edit
  def edit
    @mailing_address = MailingAddress.find(params[:id])
    render layout: @layout
  end

  # POST /mailing_addresses
  # POST /mailing_addresses.json
  def create
    @client.build_mailing_address(params[:mailing_address])

    respond_to do |format|
      if @client.save
        format.html { redirect_to polymorphic_path([@client, :mailing_addresses], load_style: :partial), notice: 'Mailing address was successfully created.' }
        format.json { render json: @mailing_address, status: :created, location: @mailing_address }
      else
        format.html { render action: "new" }
        format.json { render json: @mailing_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mailing_addresses/1
  # PUT /mailing_addresses/1.json
  def update
    @mailing_address = MailingAddress.find(params[:id])

    respond_to do |format|
      if @mailing_address.update_attributes(params[:mailing_address])
        format.html { redirect_to polymorphic_path([@client, :mailing_addresses], load_style: :partial), notice: 'Mailing address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mailing_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailing_addresses/1
  # DELETE /mailing_addresses/1.json
  def destroy
    @mailing_address = MailingAddress.find(params[:id])
    @mailing_address.destroy

    respond_to do |format|
      format.html { redirect_to polymorphic_path([@client, :mailing_addresses], load_style: :partial), notice: 'Mailing address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
