# frozen_string_literal: true

module RailsCom
  module TemplateRenderer
    
    def render(context, options)
      # todo better implement
      @lookup_context.send :_set_detail, :formats, @lookup_context.formats[0..0]
      context.instance_variable_set(:@_rendered_template, options[:template])
      super
    end
    
  end
end


ActiveSupport.on_load :action_view do
  ActionView::TemplateRenderer.prepend RailsCom::TemplateRenderer
end
