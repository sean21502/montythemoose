class Collaborator < ApplicationRecord
  belongs_to :user
  belongs_to :wiki

  def self.available(wiki, current_user)
    # Anyone who is not the wiki owner, generates an array
    possible_collaborators = User.all.where.not(id: current_user.id)
    # Does this wiki already have collaborators
    already_taken = wiki.collaborators.map { |collaborator| User.find_by_id(collaborator.user_id) }
    possible_collaborators - already_taken
    # leave us with an array with the possible collaborators
  end
end
