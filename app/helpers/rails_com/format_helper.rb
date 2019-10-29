# frozen_string_literal: true
module RailsCom::FormatHelper

  def simple_format_hash(hash_text, html_options = {}, options = {})
    wrapper_tag = options.fetch(:wrapper_tag, :p)

    hash_text.map do |k, v|
      if k.to_s.rstrip.end_with?(':')
        text = k.to_s + ' ' + v.to_s
      else
        text = k.to_s + ': ' + v.to_s
      end

      content_tag(wrapper_tag, text, html_options)
    end.join("\n\n").html_safe
  end
end

