class Admin::CommentsController < ApplicationController

  layout "layouts/admin"
  before_filter :super_admin

  def index
#    @communities = Community.all.paginate(:per_page => 15, :page => params[:page])
  end

  def edit
    @comment = Comment.find_by_id(params[:id])
    @path = admin_comment_path(:id => @comment.id.to_s)
  end

  def update
    @comment = Comment.find_by_id(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to admin_listing_path(:id => @comment.listing_id, :type => "listings"), :notice => "Comment successfully updated" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @listing = @comment.listing_id
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to admin_listing_path(:id => @listing ,:type => "listings"), :notice => "Comment successfully removed." }
      format.json { head :no_content }
    end
  end


end
