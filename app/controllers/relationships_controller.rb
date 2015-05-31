class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @relationships = current_user.following_relationships
  end

  def destroy
    relationship = current_user.following_relationships.find_by(id: params[:id])
    relationship.destroy if relationship

    redirect_to people_path
  end

  def create
    leader = User.find(params[:leader_id])
    Relationship.create(leader_id: params[:leader_id], follower: current_user) if current_user.can_follow?(leader)
    #unless current_user.follows?(leader) || current_user == leader
    redirect_to people_path
  end

end