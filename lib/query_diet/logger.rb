module QueryDiet
  class Logger

    class << self
      attr_accessor :queries, :paused

      def reset
        self.queries = []
      end

      def log(query)
        if paused?
          yield
        else
          result = nil
          time = Benchmark.realtime do
            result = yield
          end
          queries << [query, time] if log_query?(query)
          result
        end
      end

      def time
        (queries.sum(&:last) * 1000).to_i
      end

      def count
        queries.size
      end

      def paused?
        paused
      end

      private

      def log_query?(query)
        query =~ /^(select|create|update|delete|insert)\b/i
      end
    end

    reset
  end
end
