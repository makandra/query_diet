module QueryDiet
  class Logger
    DEFAULT_OPTIONS = { :bad_count => 8, :bad_time => 5000 }

    class << self
      attr_accessor :queries

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

      def bad?(options = {})
        options = options.reverse_merge(DEFAULT_OPTIONS)
        count >= options[:bad_count] or time >= options[:bad_time]
      end

      private

      def log_query?(query)
        query =~ /^(select|create|update|delete|insert)\b/i
      end
    end

    reset
  end
end
