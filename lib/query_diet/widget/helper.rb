module QueryDiet
  module Widget
    module Helper

      def query_diet_widget(options = {})
        default_html_options = {:nonce => false}
        options = options.reverse_merge(default_html_options)

        nonce_attribute = options.fetch(:nonce) ? " nonce=\"#{content_security_policy_nonce}\"" : ''

        html = Widget.css(nonce_attribute) + Widget.html(options) + Widget.js(nonce_attribute)
        html.respond_to?(:html_safe) ? html.html_safe : html
      end

    end
  end
end

ActionView::Base.send :include, QueryDiet::Widget::Helper
