# frozen_string_literal: true

module RSpec
  module Parallel
    module GoGoGo
      module ProgressFramer
        BAR_WIDTH = 5
        BAR_CHAR = "oGo"
        BAR_CHAR_LEN = BAR_CHAR.length

        module_function

        def init_display(total_processes)
          "\n" * total_processes
        end

        def display(counter, move_number)
          "\r\e[#{move_number}E" + "#{rate(counter)} #{bar(counter)} #{result(counter)}" + "\e[#{move_number}F"
        end

        def bar(counter)
          progress_bar = if counter.rate >= 1
                           completed_progress_bar
                         else
                           in_progress_bar(counter)
                         end
          RSpec::Core::Formatters::ConsoleCodes.wrap("|#{progress_bar}|", :magenta)
        end

        def result(counter)
          checks = counter.checks
          failures = counter.failures

          format("%#{checks.to_s.length}s examples, %#{failures.to_s.length}s failures", checks, failures)
        end

        def rate(counter)
          percent = (counter.rate * 100.0).to_int
          "#{format("%3s", percent)}%"
        end

        def in_progress_bar(counter)
          width = BAR_WIDTH + BAR_CHAR_LEN + BAR_CHAR_LEN
          blank_bar = (" " * blank_len(counter))
          bar = "#{blank_bar}#{BAR_CHAR}".ljust(width, " ")
          bar.slice(BAR_CHAR_LEN, BAR_WIDTH)
        end

        def blank_len(counter)
          v_len = (BAR_WIDTH + BAR_CHAR_LEN) * 2
          len = counter.checks % v_len
          if len > BAR_WIDTH + BAR_CHAR_LEN
            # reverse
            v_len - len
          else
            len
          end
        end

        def completed_progress_bar
          "=" * BAR_WIDTH
        end
      end
    end
  end
end
