if defined?(ChefSpec)
  def rbenv_ruby_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('rbenv_ruby', 'install', resource_name)
  end

  def rbenv_gem_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('rbenv_gem', 'install', resource_name)
  end
end
