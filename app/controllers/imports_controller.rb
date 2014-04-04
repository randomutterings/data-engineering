class ImportsController < ApplicationController

  def new
    @import = Import.new
  end

  def create
    @import = Import.new(import_params)

    respond_to do |format|
      begin
        Import.transaction do
          if @import.save && @import.process
            format.html { redirect_to @import, notice: 'Import processed successfully.' }
          else
            format.html { render action: 'new' }
          end
        end
      rescue Exception => exc
        Rails.logger.error("Import failed: #{exc}")
        @import.errors[:tsv] << "The import failed, please check your file and try again. Detail: #{exc}"
        format.html { render action: 'new' }
      end
    end
  end

  def show
    @import = Import.find(params[:id])
  end

  private

  def import_params
    params.require(:import).permit(:tsv)
  end

end
