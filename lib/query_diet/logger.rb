module QueryDiet
  class Logger
    class << self

      attr_accessor :count, :time, :bad_count, :bad_time

      def reset
        self.count = 0
        self.time = 0
      end

      def log(query, &execution)
        result = nil
        seconds = Benchmark.realtime do
          result = execution.call
        end
        if log_query?(query)
          self.time += (seconds * 1000).to_i
          self.count += 1
        end
        result
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
