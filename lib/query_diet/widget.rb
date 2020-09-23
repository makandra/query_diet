module QueryDiet
  module Widget
    class << self

      def css(nonce_attribute)
        <<-EOF
        <style type="text/css"#{nonce_attribute}><!--
          div#query_diet {
            position: absolute;
            top: 0;
            right: 0;
            background-color: black;
            color: white;
            z-index: 99999;
            padding: 4px 6px;
            font: normal bold 12px/12px Arial, sans-serif;
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
            font-size: 16px;
            line-height: 16px;
          }
        --></style>
        EOF
      end

      def js(nonce_attribute)
        <<-EOF
        <script type="text/javascript"#{nonce_attribute}>
          document.getElementById("query_diet").addEventListener("click", function() {
            this.parentNode.removeChild(this);
          });
        </script>
        EOF
      end

      def html(options)
        <<-EOF
        <div id="query_diet" class="#{QueryDiet::Logger.bad?(options) ? 'bad' : 'good' }">
          #{QueryDiet::Logger.count} / #{QueryDiet::Logger.time}ms
        </div>
        EOF
      end

    end

    module Helper
      def query_diet_widget(options = { 'nonce' => false })
        with_nonce = options.fetch('nonce', options[:nonce])
        nonce = with_nonce ? content_security_policy_nonce : nil
        nonce_attribute = nonce ? " nonce=\"#{nonce}\"" : ''

        html = Widget.css(nonce_attribute) + Widget.html(options) + Widget.js(nonce_attribute)
        html.respond_to?(:html_safe) ? html.html_safe : html
      end
    end

  end

end

ActionView::Base.send :include, QueryDiet::Widget::Helper
