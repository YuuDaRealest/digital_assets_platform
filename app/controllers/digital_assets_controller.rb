class DigitalAssetsController < ApplicationController
  before_action :set_digital_asset, only: %i[ show edit update destroy download ]
  before_action :set_creator
  before_action :set_current_customer

  # GET /digital_assets or /digital_assets.json
  def index
    @digital_assets = DigitalAsset.all
  end

  # GET /digital_assets/1 or /digital_assets/1.json
  def show
  end

  # GET /digital_assets/new
  def new
    @digital_asset = DigitalAsset.new
  end

  # GET /digital_assets/1/edit
  def edit
  end

  # POST /digital_assets or /digital_assets.json
  def create
    @digital_asset = DigitalAsset.new(digital_asset_params)

    respond_to do |format|
      if @digital_asset.save
        format.html { redirect_to @digital_asset, notice: "Digital asset was successfully created." }
        format.json { render :show, status: :created, location: @digital_asset }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @digital_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /digital_assets/1 or /digital_assets/1.json
  def update
    respond_to do |format|
      if @digital_asset.update(digital_asset_params)
        format.html { redirect_to @digital_asset, notice: "Digital asset was successfully updated." }
        format.json { render :show, status: :ok, location: @digital_asset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @digital_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /digital_assets/1 or /digital_assets/1.json
  def destroy
    @digital_asset.destroy!

    respond_to do |format|
      format.html { redirect_to digital_assets_path, status: :see_other, notice: "Digital asset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def bulk_import
    if params[:json_file].present?
      begin
        json_data = JSON.parse(params[:json_file].read)
        success_count = 0
        error_count = 0

        json_data.each do |asset_data|
          digital_asset = DigitalAsset.new(
            title: asset_data['title'],
            description: asset_data['description'],
            file_url: asset_data['file_url'],
            price: asset_data['price'],
            creator_id: @creator.id
          )

          if digital_asset.save
            success_count += 1
          else
            error_count += 1
          end
        end

        redirect_to digital_assets_path, notice: "Successfully imported #{success_count} assets. #{error_count} failed."
      rescue JSON::ParserError
        redirect_to digital_assets_path, alert: "Invalid JSON file format"
      end
    else
      redirect_to digital_assets_path, alert: "Please select a JSON file"
    end
  end

  def download
    unless @customer.present?
      redirect_to new_customer_session_path, alert: 'Please sign in to download assets.'
      return
    end

    unless @customer.digital_assets.include?(@digital_asset)
      redirect_to digital_assets_path, alert: 'You have not purchased this asset.'
      return
    end

    redirect_to @digital_asset.file_url, allow_other_host: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_digital_asset
      @digital_asset = DigitalAsset.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def digital_asset_params
      params.expect(digital_asset: [ :title, :description, :file_url, :price, :creator_id ])
    end

    def set_creator
      @creator = Creator.first
    end

    def set_current_customer
      @customer = Customer.first
    end
end
