class Scope #< ApplicationPolicy.rb
    # you can inherit the initilaized objects from application policy. you could then remove all the instance variables and use the variables in ApplicationPolicy.rb
  attr_reader :current_user, :model
# 'current_user' can be named anything, the object passed as 'current_user' when initialized is an activerecord 'user object' that devise supplies. it references the current_user, the model is a reference to the object that is being authorized.

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def resolve
    wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role = 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user 
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? 
            wikis << wiki
          end
        end
      end
      wikis
  end
end
