module QueryDiet
  module ActiveRecordExt
    def log(query, *)
      QueryDiet::Logger.log(query) { super }
    end
  end
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:prepend, QueryDiet::ActiveRecordExt)
