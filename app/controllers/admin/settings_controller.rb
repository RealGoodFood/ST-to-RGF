class Admin::SettingsController < ApplicationController
  layout "layouts/admin"
  before_filter :super_admin

  def new
    @text_info = FormDetail.new(params[:form_detail])
#    @path = admin_setting_path(:id => @text_info.id.to_s)
    @path = admin_settings_path
  end

  def create
    @text_info = FormDetail.new(params[:form_detail])
    respond_to do |format|
      if @text_info.save
        format.html { redirect_to admin_settings_path(:type => "texts"), :notice => "Text Information successfully updated" }
        format.json { head :no_content }
      else
        format.html { render action: "create" }
        format.json { render json: @text_info.errors, status: :unprocessable_entity } 
      end
    end
  end

  def index
      @text_info = FormDetail.first
  end

  def edit
    @text_info = FormDetail.find_by_id(params[:id])
    @path = admin_setting_path(:id => @text_info.id.to_s)
  end

  def update
    @text_info = FormDetail.find_by_id(params[:id])
    respond_to do |format|
      if @text_info.update_attributes( params[:form_detail] )
        format.html { redirect_to admin_settings_path(:type => "texts"), :notice => "Text Information successfully updated" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text_info.errors, status: :unprocessable_entity }
      end
    end
  end


end
