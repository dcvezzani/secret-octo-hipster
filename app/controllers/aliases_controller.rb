class AliasesController < ApplicationController

  before_filter :load_client
  before_filter :check_load_style

  # GET /aliases
  # GET /aliases.json
  def index
    @aliases = Alias.all

    respond_to do |format|
      format.html { render layout: @layout }# index.html.erb
      format.json { render json: @aliases }
    end
  end

  # GET /aliases/1
  # GET /aliases/1.json
  def show
    @alias = Alias.find(params[:id])

    respond_to do |format|
      format.html { render layout: @layout }# show.html.erb
      format.json { render json: @alias }
    end
  end

  # GET /aliases/new
  # GET /aliases/new.json
  def new
    @alias = Alias.new

    respond_to do |format|
      format.html { render layout: @layout }# new.html.erb
      format.json { render json: @alias }
    end
  end

  # GET /aliases/1/edit
  def edit
    @alias = Alias.find(params[:id])
    render layout: @layout
  end

  # POST /aliases
  # POST /aliases.json
  def create
    params[:alias][:client_id] = @client.id if @client
    @alias = Alias.new(params[:alias])

    respond_to do |format|
      if @alias.save
        #format.html { redirect_to alias_path(@alias, load_style: :partial), notice: 'Alias was successfully created.' }
        format.html { redirect_to polymorphic_path([@client, :aliases], load_style: :partial), notice: 'Alias was successfully created.' }
        format.json { render json: @alias, status: :created, location: @alias }
      else
        format.html { render action: "new" }
        format.json { render json: @alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aliases/1
  # PUT /aliases/1.json
  def update
    params[:alias][:client_id] = @client.id if @client
    @alias = Alias.find(params[:id])

    respond_to do |format|
      if @alias.update_attributes(params[:alias])
        #format.html { redirect_to @alias, notice: 'Alias was successfully updated.' }
        format.html { redirect_to polymorphic_path([@client, :aliases], load_style: :partial), notice: 'Alias was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aliases/1
  # DELETE /aliases/1.json
  def destroy
    @alias = Alias.find(params[:id])
    @alias.destroy

    respond_to do |format|
      #format.html { redirect_to aliases_url }
      format.html { redirect_to polymorphic_path([@client, :aliases], load_style: :partial), notice: 'Alias was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
