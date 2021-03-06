define :env_dir, :variables => Hash.new, :restarts => [] do
  env_dir = params[:name]

  directory env_dir do
    recursive true
  end

  restarts = params[:restarts]

  params[:variables].each do |key, value|
    file File.join(env_dir, key) do
      content value
      restarts.each do |svc|
        notifies :restart, svc
      end
    end
  end

  if File.directory?(env_dir)
    deleted_env_vars = Dir.entries(env_dir) - params[:variables].keys - %w{. ..}
    deleted_env_vars.each do |deleted_var|
      file File.join(env_dir, deleted_var) do
        action :delete
        restarts.each do |svc|
          notifies :restart, svc
        end
      end
    end
  end
end
