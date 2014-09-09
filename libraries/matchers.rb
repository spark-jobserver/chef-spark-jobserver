if defined?(ChefSpec)

  def start_jobserver_runit_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('runit_service', :start, resource_name)
  end

end
