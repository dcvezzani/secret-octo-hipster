class SettlorsController < ApplicationController
  # GET /settlors
  # GET /settlors.json
  def index
    @settlors = Settlor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @settlors }
    end
  end

  # GET /settlors/1
  # GET /settlors/1.json
  def show
    @settlor = Settlor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @settlor }
    end
  end

  # GET /settlors/new
  # GET /settlors/new.json
  def new
    @settlor = Settlor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @settlor }
    end
  end

  # GET /settlors/1/edit
  def edit
    @settlor = Settlor.find(params[:id])
  end

  # POST /settlors
  # POST /settlors.json
  def create
    @settlor = Settlor.new(params[:settlor])

    respond_to do |format|
      if @settlor.save
        format.html { redirect_to @settlor, notice: 'Settlor was successfully created.' }
        format.json { render json: @settlor, status: :created, location: @settlor }
      else
        format.html { render action: "new" }
        format.json { render json: @settlor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /settlors/1
  # PUT /settlors/1.json
  def update
    @settlor = Settlor.find(params[:id])

    respond_to do |format|
      if @settlor.update_attributes(params[:settlor])
        format.html { redirect_to @settlor, notice: 'Settlor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @settlor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settlors/1
  # DELETE /settlors/1.json
  def destroy
    @settlor = Settlor.find(params[:id])
    @settlor.destroy

    respond_to do |format|
      format.html { redirect_to settlors_url }
      format.json { head :no_content }
    end
  end
end
