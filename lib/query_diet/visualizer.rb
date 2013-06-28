module QueryDiet
  module Widget
    class Visualizer

      DEFAULT_FONT_SIZE = 16

      def initialize(options = {})
        @base_queries = options[:base_queries] || 8
        @growth_per_query = options[:growth_per_query] || 2
      end

      def html
        <<-EOF
        <div id="query_diet" class="#{bad? ? 'bad' : 'good' }" onclick="this.parentNode.removeChild(this);">
          #{count} #{count == 1 ? 'query' : 'queries'}
        </div>
        EOF
      end

      def css
        <<-EOF
        <style type="text/css"><!--
          div#query_diet {
            position: fixed;
            top: 0;
            right: 0;
            background-color: black;
            color: white;
            z-index: 999;
            padding: 4px 10px 10px 10px;
            font: normal bold 16px/16px Arial, sans-serif;
            cursor: pointer;
          }
          div#query_diet.good {
            filter:alpha(opacity=30);
            -moz-opacity:0.3;
            -khtml-opacity: 0.3;
            opacity: 0.3;
          }
          div#query_diet.bad {
            background-color: red;
            font-size: #{font_size_by_query_count}px;
            line-height: #{font_size_by_query_count}px;
          }
        --></style>
        EOF
      end

      private

      def bad?
        count > @base_queries
      end

      def count
        QueryDiet::Logger.count
      end

      def font_size_by_query_count
        overrun = count - @base_queries
        if overrun > 0
          DEFAULT_FONT_SIZE + @growth_per_query * overrun
        else
          DEFAULT_FONT_SIZE
        end
      end

    end
  end
end