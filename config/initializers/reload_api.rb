if Rails.env.development?
	ActiveSupport::Dependencies.explicitly_unloadable_constants << 'MailFunnel::API'

	api_files = Dir[Rails.root.join('app', 'api', '**', '*.rb')]
	api_files += Dir["#{Rails.root}/app/api/*"]
	# config.paths.add 'app/api', glob: '**/*.rb'
	api_reloader = ActiveSupport::FileUpdateChecker.new(api_files) do
		Rails.application.reload_routes!
	end
	ActionDispatch::Callbacks.to_prepare do
		api_reloader.execute_if_updated
	end
end