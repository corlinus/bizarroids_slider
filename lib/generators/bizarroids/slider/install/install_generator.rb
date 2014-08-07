require 'rails/generators/active_record/migration'

class Bizarroids::Slider::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  include ActiveRecord::Generators::Migration

  def copy_migration
    migration_template 'migration.rb', 'db/migrate/create_bizarroids_slider_tables.rb'
  end

  def create_initalizer
    initializer 'bizarroids_slider.rb', File.read(File.join(self.class.source_root, 'initializer.rb'))
  end

  def add_route
    route "mount Bizarroids::Slider::Engine => '/admin'"
  end

  def copy_translation_files
    copy_file "bizarroids_slider.en.yml", "config/locales/bizarroids_slider.en.yml"
    copy_file "bizarroids_slider.ru.yml", "config/locales/bizarroids_slider.ru.yml"
  end
end
