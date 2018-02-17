class ConsignmentsController < ApplicationController
  before_action :set_consignment, only: [:show, :edit, :update, :destroy]
  before_action :set_status_options, :set_payment_status_options, only: [:new, :create, :edit, :update]

  # GET /consignments
  # GET /consignments.json
  def index
    @consignments = Consignment.newest_first.page params[:page]
  end

  # GET /consignments/1
  # GET /consignments/1.json
  def show
  end

  # GET /consignments/new
  def new
    @consignment = Consignment.new
    if @consignment.tracking_code.blank?
      # code = (0..9).to_a + ('A'..'F').to_a
      # tracking_id = (0..6).map{code.sample}.join
      tracking_id = ([*('0'..'9'),*('A'..'Z')]-%w(0 1 I O)).sample(5).join
      @consignment.tracking_code = tracking_id
    end
  end

  # GET /consignments/1/edit
  def edit
  end

  # POST /consignments
  # POST /consignments.json
  def create
    @consignment = Consignment.new(consignment_params)

    respond_to do |format|
      if @consignment.save
        format.html { redirect_to @consignment, notice: 'Consignment was successfully created.' }
        format.json { render :show, status: :created, location: @consignment }
      else
        format.html { render :new }
        format.json { render json: @consignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consignments/1
  # PATCH/PUT /consignments/1.json
  def update
    respond_to do |format|
      if @consignment.update(consignment_params)
        format.html { redirect_to @consignment, notice: 'Consignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @consignment }
      else
        format.html { render :edit }
        format.json { render json: @consignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consignments/1
  # DELETE /consignments/1.json
  def destroy
    @consignment.destroy
    respond_to do |format|
      format.html { redirect_to consignments_url, notice: 'Consignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consignment
      @consignment = Consignment.find(params[:id])
    end

  # Set Consignment status
  def set_status_options
    @status = {Success: :success, Delivered: :delivered, Not_delivered: :not_delivered, Due: :due }
  end

  # Set payment status
  def set_payment_status_options
    @payment_status = {Given: :given, Not_yet: :not_yet }
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consignment_params
      params.require(:consignment).permit(:merchant_id, :plan_id, :tracking_code, :receiver_name, :receiver_phone, :receiver_addr, :amount, :weight, :charge, :additional_cost, :compensation, :payment_status, :merchant_order_no, :package_description, :delivered_on,:current_hub_id, :target_hub_id, :rider, :assigned_by, :data_entry_by, :completed_by,:assigned_on, :assigned_on, :completed_on, :data_entry_on, :status)
    end
end
