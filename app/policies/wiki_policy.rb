class WikiPolicy #< ApplicationPolicy.rb
    # you can inherit the initilaized objects from application policy. you could then remove all the instance variables and use the variables in ApplicationPolicy.rb
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

end