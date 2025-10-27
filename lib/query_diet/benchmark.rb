module QueryDiet
  module Benchmark
    class << self
      def realtime
        r0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        yield
        Process.clock_gettime(Process::CLOCK_MONOTONIC) - r0
      end
    end
  end
end
