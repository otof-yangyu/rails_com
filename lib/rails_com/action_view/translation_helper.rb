module RailsCom
  module TranslationHelper

    def t(key, options = {})
      options[:default] ||= default_keys(key)
      super
    end

    def default_keys(key)
      [
        "controller#{key}".to_sym,
        "#{controller_path.split('/').join('.')}.#{action_name}#{key}".to_sym
      ]
    end

  end
end

ActiveSupport.on_load :action_view do
  include RailsCom::TranslationHelper
end
