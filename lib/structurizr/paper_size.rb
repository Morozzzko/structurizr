# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class PaperSize < DelegateClass(Metal::View::PaperSize)
    extend Utils::JavaEnum[Metal::View::PaperSize]
  end
end
