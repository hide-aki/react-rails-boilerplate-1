class SiteOptionsController < ApplicationController
  before_action :set_site_option, only: [:show, :edit, :update, :destroy]

  # GET /site_options
  # GET /site_options.json
  def index
    @site_options = SiteOption.page params[:page]
  end

  # GET /site_options/1
  # GET /site_options/1.json
  def show
  end

  # GET /site_options/new
  def new
    @site_option = SiteOption.new
  end

  # GET /site_options/1/edit
  def edit
  end

  # POST /site_options
  # POST /site_options.json
  def create
    @site_option = SiteOption.new(site_option_params)

    respond_to do |format|
      if @site_option.save
        format.html { redirect_to @site_option, notice: 'Site option was successfully created.' }
        format.json { render :show, status: :created, location: @site_option }
      else
        format.html { render :new }
        format.json { render json: @site_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_options/1
  # PATCH/PUT /site_options/1.json
  def update
    respond_to do |format|
      if @site_option.update(site_option_params)
        format.html { redirect_to @site_option, notice: 'Site option was successfully updated.' }
        format.json { render :show, status: :ok, location: @site_option }
      else
        format.html { render :edit }
        format.json { render json: @site_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_options/1
  # DELETE /site_options/1.json
  def destroy
    @site_option.destroy
    respond_to do |format|
      format.html { redirect_to site_options_url, notice: 'Site option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_option
      @site_option = SiteOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_option_params
      params.require(:site_option).permit(:key, :value)
    end
end
