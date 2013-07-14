module QueryDiet
  module Widget
    module Helper
      require File.join(File.dirname(__FILE__), 'visualizer')
      
      def query_diet_widget(options = {})
        visualizer = Visualizer.new(options)
        html = visualizer.css + visualizer.html
        html.respond_to?(:html_safe) ? html.html_safe : html
      end
    end
  end
end

ActionView::Base.send :include, QueryDiet::Widget::Helper
