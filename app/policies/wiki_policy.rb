class WikiPolicy #< ApplicationPolicy.rb
  # you can inherit the initialized objects from application policy. you could then remove all the instance variables and use the variables in ApplicationPolicy.rb
  attr_reader :current_user, :model
  # 'current_user' can be named anything, the object passed as 'current_user' when initialized is an activerecord 'user object' that devise supplies. it references the current_user, the model is a reference to the object that is being authorized.
  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def index?
    !!@current_user
  end

  def new?
    !!@current_user
  end

  def create?
    !!@current_user
  end

  def edit?
    @model.user == @current_user || @current_user.admin?
  end

  def update?
    @model.user == @current_user || @current_user.admin?
  end

  def destroy?
    @model.user == @current_user || @current_user.admin?
  end

  def show?
    !!@current_user
  end

  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
            # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           if !wiki.private? || wiki.user_id == user.id || wiki.collaborators.include?(user.id)
             wikis << wiki
             #first condition is if its public?
             #second tests if they are owner for private wikis
             #third collaborators

           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           # only show standard users public wikis and private wikis they are a collaborator on
           if !wiki.private? || wiki.collaborators.include?(user.id)
             wikis << wiki
             # first is public? second collaborators?
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end
end