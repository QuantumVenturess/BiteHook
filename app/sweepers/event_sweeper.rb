class EventSweeper < ActionController::Caching::Sweeper
	observe Event

	def sweep(event)
		expire_page events_path
		expire_page event_path(event)
		FileUtils.rm_rf "#{page_cache_directory}/events"
	end
	alias_method :after_update, :sweep
	alias_method :after_create, :sweep
	alias_method :after_destroy, :sweep
end