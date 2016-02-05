ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do

  def log_with_query_diet(query, *args, &block)
    QueryDiet::Logger.log(query) do
      log_without_query_diet(query, *args, &block)
    end
  end

  alias_method :log_without_query_diet, :log
  alias_method :log, :log_with_query_diet

end
