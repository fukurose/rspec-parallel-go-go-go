# frozen_string_literal: true

require "rspec/parallel/go_go_go/progress_counter"
require "rspec/parallel/go_go_go/progress_framer"

require "rspec/core"
require "rspec/core/formatters/base_text_formatter"

require "parallel_tests"

module RSpec
  module Parallel
    module GoGoGo
      class Formatter < RSpec::Core::Formatters::BaseTextFormatter
        RSpec::Core::Formatters.register self, :start, :example_passed, :example_failed, :dump_failures, :dump_summary

        def start(notification)
          super
          test_number = ENV.fetch("TEST_ENV_NUMBER", "1")
          @current_process_number = test_number.empty? ? 1 : test_number.to_i
          @total_processes = ENV.fetch("PARALLEL_TEST_GROUPS", "1").to_i

          @counter = ProgressCounter.new(notification.count)
          @output << ProgressFramer.init_display(@total_processes)
          @output << "\e[#{@total_processes}A"
        end

        def example_passed(*)
          @counter.passed
          @output << ProgressFramer.display(@counter, @current_process_number)
        end

        def example_failed(*)
          @counter.failed
          @output << ProgressFramer.display(@counter, @current_process_number)
        end

        def dump_failures(*); end

        def dump_summary(*); end

        def dump_pending(*); end

        def close(*)
          return if @output.closed?

          if ParallelTests.first_process?
            ParallelTests.wait_for_other_processes_to_finish
            @output << "\e[#{@total_processes}E"
          end

          @output.flush
        end
      end
    end
  end
end
