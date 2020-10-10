# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class Shape < DelegateClass(Metal::View::Shape)
  end
end
