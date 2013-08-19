class RegistrationsController < Devise::RegistrationsController
  after_filter :add_account 

  protected

  def add_account
    if resource.persisted? # user is created successfuly
      resource.lists.create(name: "My List")
    end
 end
end
