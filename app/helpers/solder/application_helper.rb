module Solder
  module ApplicationHelper
    def solder_onto(name, &block)
      fragment = Nokogiri::HTML.fragment(capture(&block).squish)

      first_fragment_child = fragment.first_element_child

      # add stimulus controller and create unique key
      first_fragment_child["data-controller"] = "#{first_fragment_child["data-controller"]} solder".strip
      first_fragment_child["data-solder-key-value"] = solder_key(name)

      # rehydrate
      ui_state = Rails.cache.read "solder/#{solder_key(name)}"

      ui_state&.each do |attribute_name, value|
        first_fragment_child[attribute_name] = value
      end

      first_fragment_child.to_html.html_safe
    end

    def solder_key(name)
      key = cache_fragment_name(name, skip_digest: true)
              .flatten
              .compact
              .map(&:cache_key)
              .join(":")

      key += ":#{caller.find { _1 =~ /html/ }}"

      ActiveSupport::Digest.hexdigest(key)
    end
  end
end
