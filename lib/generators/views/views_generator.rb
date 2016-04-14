class ViewsGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../../app/views", __FILE__)

  def copy_views
    directory 'shopper_engine', 'app/views/shopper_engine'
  end
end
