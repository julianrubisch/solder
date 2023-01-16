module Solder
  module ApplicationHelper
    def solder_onto(name, touch: [], attribute_safelist: ["class"], &block)
      soldered_html = capture(&block).to_s.strip
      fragment = Nokogiri::HTML.fragment(soldered_html)

      first_fragment_child = fragment.first_element_child

      # rehydrate
      ui_state = Rails.cache.read "solder/#{solder_key(name)}"

      ui_state&.select { attribute_safelist.include?(_1) }&.each do |attribute_name, value|
        first_fragment_child[attribute_name] = sanitize(value, tags: [])
      end

      # add stimulus controller and create unique key
      first_fragment_child["data-controller"] = "#{first_fragment_child["data-controller"]} solder".strip
      first_fragment_child["data-solder-key-value"] = solder_key(name)

      first_fragment_child["data-solder-touch"] ||= Array(touch).map(&:to_sgid).map(&:to_s).join(":")

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
