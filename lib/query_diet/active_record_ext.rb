module QueryDiet
  module ActiveRecordExt
    if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3')
      def log(query, *, **)
        QueryDiet::Logger.log(query) { super }
      end
    else
      def log(query, *)
        QueryDiet::Logger.log(query) { super }
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:prepend, QueryDiet::ActiveRecordExt)
end
