class Shared::FlashMessagesComponent < ViewComponent::Base
  def initialize(flash)
    @flash = flash
  end

  def render?
    @flash.any?
  end

  def alert_class(type)
    case type
    when "notice"
      "bg-green-50 border-l-4 border-green-500 text-green-800"
    when "alert"
      "bg-red-50 border-l-4 border-red-500 text-red-800"
    when "warning"
      "bg-yellow-50 border-l-4 border-yellow-500 text-yellow-800"
    else
      "bg-blue-50 border-l-4 border-blue-500 text-blue-800"
    end
  end

  def icon(type)
    case type
    when "notice"
      "✓"
    when "alert"
      "✕"
    when "warning"
      "⚠"
    else
      "ℹ"
    end
  end
end
