# frozen_string_literal: true

module RailsCom
  module TemplateRenderer
    def render(context, options)
      context.instance_variable_set(:@_rendered_template, options[:template])
      super
    end
  end
end


ActiveSupport.on_load :action_view do
  ActionView::TemplateRenderer.prepend RailsCom::TemplateRenderer
end
