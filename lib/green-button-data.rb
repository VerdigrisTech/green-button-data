require 'sax-machine'

require 'green-button-data/core_ext'
require 'green-button-data/utilities'
require 'green-button-data/parser'
require 'green-button-data/parser/interval'
require 'green-button-data/parser/authorization'
require 'green-button-data/parser/application_information'
require 'green-button-data/parser/service_category'

module GreenButtonData
  SERVICE_CATEGORY = {
    0 => 'electricity',
    1 => 'gas',
    2 => 'water',
    3 => 'time',
    4 => 'heat',
    5 => 'refuse',
    6 => 'sewage',
    7 => 'rates',
    8 => 'tvLicense',
    9 => 'internet'
  }
end
