class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @relationships = current_user.following_relationships
  end

  def destroy
    relationship = current_user.following_relationships.find_by(id: params[:id])
    relationship.destroy if relationship

    redirect_to people_path

    # relationship = Relationship.find(params[:id])
    # relationship.destroy if relationship.follower == current_user
    # redirect_to people_path
  end

end