class ActivityavatarsController < ApplicationController
  # GET /activityavatars
  # GET /activityavatars.json
  def index
    @activityavatars = Activityavatar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activityavatars }
    end
  end

  # GET /activityavatars/1
  # GET /activityavatars/1.json
  def show
    @activityavatar = Activityavatar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activityavatar }
    end
  end

  # GET /activityavatars/new
  # GET /activityavatars/new.json
  def new
    @activityavatar = Activityavatar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activityavatar }
    end
  end

  # GET /activityavatars/1/edit
  def edit
    @activityavatar = Activityavatar.find(params[:id])
  end

  # POST /activityavatars
  # POST /activityavatars.json
  def create
    @activityavatar = Activityavatar.new(params[:activityavatar])

    respond_to do |format|
      if @activityavatar.save
        format.html { redirect_to @activityavatar, notice: 'Activityavatar was successfully created.' }
        format.json { render json: @activityavatar, status: :created, location: @activityavatar }
      else
        format.html { render action: "new" }
        format.json { render json: @activityavatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activityavatars/1
  # PUT /activityavatars/1.json
  def update
    @activityavatar = Activityavatar.find(params[:id])

    respond_to do |format|
      if @activityavatar.update_attributes(params[:activityavatar])
        format.html { redirect_to @activityavatar, notice: 'Activityavatar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activityavatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activityavatars/1
  # DELETE /activityavatars/1.json
  def destroy
    @activityavatar = Activityavatar.find(params[:id])
    @activityavatar.destroy

    respond_to do |format|
      format.html { redirect_to activityavatars_url }
      format.json { head :no_content }
    end
  end
end
