class CollaboratorsController < ApplicationController
  def create

  	@collaboration = Collaborator.new(collaborators_params)

  	if @collaboration.save
  		flash[:notice] = "User is a collaborator."
      redirect_to @collaboration.wiki
    else
      flash[:alert] = "Error adding the user. Please try again."
      redirect_to Wiki.find_by(params[:collaborator][:wiki_id])
    end
  end

  def destroy

  	@collaboration = Collaborator.find(params[:id])

  	if @collaboration.destroy
      flash[:notice] = "User has been deleted"
      redirect_to @collaboration.wiki
    else
      flash[:alert] = "There was an error deleteing the user."
      redirect_to @collaboration.wiki
    end
  end

  private

  def collaborators_params
  	params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end
