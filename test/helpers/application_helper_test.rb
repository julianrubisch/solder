require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  include Solder::ApplicationHelper

  setup do
    @post = posts(:one)
    @user = users(:one)

    Rails.cache.stubs(:read).returns({
      "class" => "foo",
      "data-controller" => "collapse",
      "data-action" => "baz#bop"
    })
  end

  test "the default safelist only includes class" do
    html = solder_onto([@post, @user]) do
      tag.div class: "foo", data: {action: "collapse#toggle"} do
        "bar"
      end
    end

    element = Nokogiri::HTML.fragment(html).first_element_child

    # empty toucheable records
    assert element["data-solder-touch"]
    assert element["data-solder-key-value"]
    assert_equal "solder", element["data-controller"]
    assert_equal "foo", element["class"]

    # only safelisted attributes are rehydrated
    assert_equal "collapse#toggle", element["data-action"]
  end

  test "safelisted attributes are rehydrated" do
    html = solder_onto([@post, @user], attribute_safelist: ["class", "data-action"]) do
      tag.div class: "foo", data: {action: "collapse#toggle", controller: "collapse"} do
        "bar"
      end
    end

    element = Nokogiri::HTML.fragment(html).first_element_child

    # empty toucheable records
    assert element["data-solder-touch"]
    assert element["data-solder-key-value"]
    assert_equal "collapse solder", element["data-controller"]
    assert_equal "foo", element["class"]

    # only safelisted attributes are rehydrated
    assert_equal "baz#bop", element["data-action"]
  end

  test "non-safelisted attributes are still rendered, just not rehydrated" do
    html = solder_onto([@post, @user]) do
      tag.div class: "foo", data: {action: "collapse#toggle"} do
        "bar"
      end
    end

    element = Nokogiri::HTML.fragment(html).first_element_child

    # empty touchable records
    assert element["data-solder-touch"]
    assert element["data-solder-key-value"]
    assert_equal "solder", element["data-controller"]
    assert_equal "foo", element["class"]

    # not safelisted attributes are still rendered, just not rehydrated
    assert_equal "collapse#toggle", element["data-action"]
  end
end
