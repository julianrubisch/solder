# 🧑‍🏭 Solder
Persist and restore ephemeral attributes of HTML elements using the Rails cache store and StimulusJS

In short, this plugin will persist UI state changes a user makes on a per-element basis.

This is useful for
- storing the open/closed state of a sidebar, accordion, etc.
- storing the state of tree views (e.g. storefront categories),
- custom dashboard layouts
- etc.

![A Cyborg Hand Soldering, Steampunk Style](https://user-images.githubusercontent.com/4352208/208506264-db5abac6-7d33-4504-9c0d-2d5f8c26994b.png)

_Image: [openjourney](https://replicate.com/prompthero/openjourney), prompt: mdjrny-v4 style cyborg soldering a piece of code onto a web application user interface, 8k, steampunk_

## Rationale

Modern server-side rendering techniques like Turbo Frames/Streams, StimulusReflex and others require to persist state on the server to facilitate rerendering without UI discrepancies.

Typically, you have a few options to achieve this:
- ActiveRecord,
- the `session`,
- [Kredis](https://github.com/rails/kredis)
are the most frequent ones. It requires you to invent keys to access the state of UI elements, e.g. `session[:collapsed_categories]` etc.
Experience shows that the management of those keys tends to increase complexity.

Hence, the part that this gem takes care of is the automatic generation and management of those keys.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "solder"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install solder
```

## Usage

In your view, use the `solder_onto` helper to create a unique key for the element whose attributes you want to track. For example, imagine we have an online store with multiple category-specific landing pages. There's a tree view on it for further filtering items:

```erb
<%= solder_onto([current_user, @category] do %>
  <details>
    <summary>Outdoor Equipment</summary>
    
    <details> ... </details>
  </details>
<% end %>
```

**IMPORTANT**: 
1. The helper only takes care of the attributes of the **first child** within it. This is because of how [`capture`](https://api.rubyonrails.org/classes/ActionView/Helpers/CaptureHelper.html#method-i-capture) works.
2. Think of the first argument to `solder_onto` as something akin to a cache key. You want it to be unique with regard to (almost always) the logged in user, and any other record it is scoped to. In fact, it adheres to the same interface as [`cache`](https://api.rubyonrails.org/classes/ActionView/Helpers/CacheHelper.html#method-i-cache)


## Dependencies

### Ruby
- Rails

### Javascript

- Stimulus
- @rails/request.js

## Persistence

Uses the active Rails cache store, possibly more adapters to come.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
