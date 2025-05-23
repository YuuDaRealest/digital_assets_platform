class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[ show edit update destroy ]
  before_action :set_current_customer


  # GET /purchases or /purchases.json
  def index
    @purchases = @customer.purchases.includes(purchase_items: { digital_asset: :creator })
                  .order(created_at: :desc)
  end

  # GET /purchases/1 or /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases or /purchases.json
  def create
    @purchase = @customer.purchases.create!(status: 'completed')
    
    params[:digital_asset_ids].each do |asset_id|
      digital_asset = DigitalAsset.find(asset_id)
      @purchase.add_item(digital_asset)
    end

    redirect_to purchases_path, notice: 'Purchase completed successfully!'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to digital_assets_path, alert: 'Failed to complete purchase.'
  end

  # PATCH/PUT /purchases/1 or /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: "Purchase was successfully updated." }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1 or /purchases/1.json
  def destroy
    @purchase.destroy!

    respond_to do |format|
      format.html { redirect_to purchases_path, status: :see_other, notice: "Purchase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download
    @digital_asset = DigitalAsset.find(params[:id])
    
    unless @customer.digital_assets.include?(@digital_asset)
      redirect_to purchases_path, alert: 'You have not purchased this asset.'
      return
    end

    # In a real application, you would implement secure file download here
    # For now, we'll just redirect to the file_url
    redirect_to @digital_asset.file_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def purchase_params
      params.expect(purchase: [ :customer_id ])
    end

    def set_current_customer
      @customer = Customer.first
    end
end
