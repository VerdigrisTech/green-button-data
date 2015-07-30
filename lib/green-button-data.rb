require 'sax-machine'

require 'green-button-data/core_ext'
require 'green-button-data/utilities'
require 'green-button-data/parser'
require 'green-button-data/parser/period'

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
