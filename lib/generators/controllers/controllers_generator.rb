class ControllersGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../../app/controllers", __FILE__)

  def copy_controllers
    directory 'shopper_engine', 'app/controllers/shopper_engine'
  end
end
