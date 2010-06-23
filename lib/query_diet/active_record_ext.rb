ActiveRecord::Base.connection.class.class_eval do

  def execute_with_query_diet(query, name = nil)
    QueryDiet::Logger.log(query) do
      execute_without_query_diet(query, name)
    end
  end

  alias_method_chain :execute, :query_diet

end
