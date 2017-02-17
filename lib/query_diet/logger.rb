module QueryDiet
  class Logger
    DEFAULT_OPTIONS = { :bad_count => 8, :bad_time => 5000 }

    class << self
      attr_accessor :queries, :paused

      def reset
        self.queries = []
      end

      def log(query)
        time = 0

        begin
          if paused?
            yield
          else
            result = nil
            time = Benchmark.realtime do
              result = yield
            end
            result
          end

        ensure
          # We need this in an ensure because it's possible the adapter will
          # include a break, in which case we otherwise wouldn't get past the
          # call to Benchmark#realtime.
          queries << [query, time] if log_query?(query)
        end
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

      def paused?
        paused
      end

      private

      def log_query?(query)
        query =~ /^\s*(select|create|update|delete|insert)\b/i
      end
    end

    reset
  end
end
