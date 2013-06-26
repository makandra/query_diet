module QueryDiet
  module Widget
    class Visualizer
        
      DEFAULT_FONT_SIZE = 16
      MAX_FONT_SIZE = 120  
        
      def initialize(options = {})
        @bad_count = options[:bad_count] || 8
        @bad_time = options[:bad_time] || 5000
      end
      
      def html
        <<-EOF
        <div id="query_diet" class="#{bad? ? 'bad' : 'good' }" onclick="this.parentNode.removeChild(this);">
          #{count} / #{time}ms
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
            padding-top: 0.1em;
            padding-bottom: 0.1em;
            padding-left: 0.2em;
            padding-right: 0.2em;
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
            font-size: #{font_size}px;
            line-height: #{font_size}px;
          }
        --></style>
        EOF
      end
      
      private
       
      def bad?
        count >= @bad_count or time >= (@bad_time/1000)
      end
      
      def count 
        QueryDiet::Logger.count
      end
      
      def time
        QueryDiet::Logger.time
      end
      
      def font_size
        calculated_font_size = [font_size_by_query_count, font_size_by_query_time].max
        normalised_font_size = [calculated_font_size, MAX_FONT_SIZE].min
        @font_size ||= normalised_font_size
      end
      
      def font_size_by_query_count
        overrun = count - @bad_count
        if overrun > 0
          overrun_degree = fibonaci(overrun) 
          (((overrun_degree.to_f/@bad_count.to_f) * DEFAULT_FONT_SIZE) + DEFAULT_FONT_SIZE).to_i
        else
          DEFAULT_FONT_SIZE  
        end
      end
      
      def font_size_by_query_time
        overrun = time - (@bad_time / 1000)
        if overrun > 0
          overrun_degree = fibonaci(overrun)
          (((overrun_degree.to_f/(@bad_time/1000).to_f) * DEFAULT_FONT_SIZE) + DEFAULT_FONT_SIZE).to_i
        else
          DEFAULT_FONT_SIZE  
        end
      end
      
      def fibonaci(upto)
        x1 = x2 = fx = 1
        upto.times do
          fx = x1 + x2
          x1 = x2
          x2 = fx  
        end
        fx  
      end
      
    end
  end 
end