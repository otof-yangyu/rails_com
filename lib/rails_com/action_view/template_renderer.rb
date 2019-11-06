# frozen_string_literal: true

module RailsCom
  module TemplateRenderer

    def render(context, options)
      if context.request
        request_format = context.request.format.symbol
        if request_format == :js
          # workaround default 'html_fallback_for_js' behavior
          # make js.erb View-Layer Inheritance possible
          # https://github.com/rails/rails/issues/34499
          @lookup_context.send :_set_detail, :formats, [:js]
        end
      end

      context.instance_variable_set(:@_rendered_template, options[:template])

      super
    end
  end
end


ActiveSupport.on_load :action_view do
  ActionView::TemplateRenderer.prepend RailsCom::TemplateRenderer
end
