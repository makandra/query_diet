module QueryDiet
  class Logger
    class << self
      attr_accessor :queries, :bad_count, :bad_time

      def reset
        self.queries = []
      end

      def log(query)
        result = nil
        time = Benchmark.realtime do
          result = yield
        end
        queries << [query, time] if log_query?(query)
        result
      end

      def time
        (queries.sum(&:last) * 1000).to_i
      end

      def count
        queries.size
      end

      def bad?
        count >= bad_count or time >= bad_time
      end

      private

      def log_query?(query)
        query =~ /^(select|create|update|delete|insert)\b/i
      end
    end

    reset
    self.bad_count = 8
    self.bad_time = 5000
  end
end
