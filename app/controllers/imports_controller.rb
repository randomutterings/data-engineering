class ImportsController < ApplicationController

  def new
    @import = Import.new
  end

  def create
    @import = Import.new(import_params)

    respond_to do |format|
      if @import.save && @import.process
        format.html { redirect_to @import, notice: 'Import processed successfully.' }
      else
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
