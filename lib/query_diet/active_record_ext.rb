module QueryDiet
  module ActiveRecordExt
    if RUBY_VERSION >= '3'
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

ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:prepend, QueryDiet::ActiveRecordExt)
