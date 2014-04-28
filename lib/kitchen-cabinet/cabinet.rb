#!/usr/bin/env ruby
# Encoding: utf-8
# Cabinet helps create and maintain cookbooks
# complete with an opinionated testing suite.
class Cabinet
  require 'fileutils'
  require 'erubis'
  def self.init(cookbook_name, options, cookbook_path)
    init_chef(cookbook_name, options, cookbook_path)
    init_git(cookbook_name, options, cookbook_path)
    init_berkshelf(cookbook_name, options, cookbook_path)
    init_kitchen(cookbook_name, cookbook_path)
    init_spec(cookbook_name, cookbook_path)
    write_configs(cookbook_name, options, cookbook_path)
    puts "Cookbook #{cookbook_name} created successfully"
    puts 'Next steps...'
    puts "  $ cd #{cookbook_path}"
    puts '  $ bundle install'
    puts '  $ bundle exec berks install'
  end

  def self.chef_check
    if File.exist?('/opt/chef')
      ENV['GEM_HOME'] = '/opt/chef/embedded/lib/ruby/gems/1.9.1'
    elsif File.exist?('C:\opscode\chef\\')
      ENV['GEM_HOME'] = 'C:\opscode\chef\embedded\lib\ruby\gems\1.9.1'
    elsif Gem::Specification.find_by_name('chef')
      ENV['GEM_HOME']
    else
      puts 'You don\'t appear to have chef installed.'
      puts 'Please install the gem or omnibus version - `gem install chef` or http://www.getchef.com/chef/install/'
      exit
    end
  end

  def self.chef_rewrite(cookbook_path)
    %w(metadata.rb recipes/default.rb).each do |file|
      puts "\tRewriting #{file}"
      contents = "\# Encoding: utf-8\n#{File.read(File.join(cookbook_path, file))}"
      File.open(File.join(cookbook_path, file), 'w') { |f| f.write(contents) }
    end
    metadata_replace = File.read(File.join(cookbook_path, 'metadata.rb'))
    replace = metadata_replace.gsub(/version          '0.1.0'/, "version IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue \"0.1.0\"")
    File.open(File.join(cookbook_path, 'metadata.rb'), 'w') { |file| file.puts replace }
  end

  def self.init_chef(cookbook_name, options, cookbook_path)
    tool = 'chef'
    puts "* Initializing #{tool}"
    cookbook_path = options[:path]
    if File.exist?(File.join(ENV['HOME'], '.chef', 'knife.rb'))
      `knife cookbook create #{cookbook_name} -o #{cookbook_path} -r md`
    else
      copyright = options[:copyright]  || 'Copyright_Holder'
      license   = options[:license]    || 'License_Type'
      email     = options[:email]      || 'Email'
      `knife cookbook create #{cookbook_name} -C #{copyright} -I #{license} -m #{email} -o #{cookbook_path} -r md`
    end
  end

  def self.init_git(cookbook_name, options, cookbook_path)
    tool = 'git'
    puts "* Initializing #{tool}"
    require 'git'
    Git.init(cookbook_path, git_dir: "#{cookbook_path}/.git")
  end

  def self.init_berkshelf(cookbook_name, options, cookbook_path)
    tool = 'berkshelf'
    puts "* Initializing #{tool}"
    require 'berkshelf'
    require 'berkshelf/base_generator'
    require 'berkshelf/init_generator'
    Berkshelf::InitGenerator.new(
      [cookbook_path],
        skip_test_kitchen: true,
        skip_vagrant: true
    ).invoke_all
  end

  def self.init_kitchen(cookbook_name, cookbook_path)
    tool = 'kitchen'
    puts "* Initializing #{tool}"
    require 'kitchen'
    require 'kitchen/generator/init'
    Kitchen::Generator::Init.new([], {}, destination_root: cookbook_path).invoke_all
  end

  def self.init_spec(cookbook_name, cookbook_path)
    require 'kitchen-cabinet/spec'
    @tool = %w(chefspec serverspec)
    @tool.each do |tool|
      Spec.install_specs(tool, cookbook_path, cookbook_name)
    end
  end

  def self.write_configs(cookbook_name, options, cookbook_path)
    @template = %w(chefignore .gitignore Gemfile Berksfile .kitchen.yml Guardfile Thorfile .rubocop.yml VERSION)
    puts 'this is the ' + cookbook_name + ' cookbook.'
    require 'kitchen-cabinet/config'
    @template.each do |template|
      Initconfig.write_config(cookbook_name, options, cookbook_path, template)
    end
  end
end
