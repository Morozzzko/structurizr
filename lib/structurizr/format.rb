# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class Format < DelegateClass(Metal::Documentation::Format)
  end
end
