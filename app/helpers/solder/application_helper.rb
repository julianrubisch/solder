module Solder
  module ApplicationHelper
    def solder_key(name)
      key = cache_fragment_name(name, skip_digest: true)
        .flatten
        .compact
        .map(&:cache_key)
        .join(":")

      key += ":#{caller(1..1).first}"

      ActiveSupport::Digest.hexdigest(key)
    end
  end
end
