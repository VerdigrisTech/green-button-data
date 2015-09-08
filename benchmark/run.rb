$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/../lib/green-button-data'))
require 'green-button-data'
require 'benchmark'
require_relative 'fixtures'

total_size = 0
total_parsetime = 0

Fixtures::FIXTURES.each do |fixture, filename|
  size = File.size "#{File.dirname __FILE__}/fixtures/#{filename}"
  size_in_mb = size / 1024.0 ** 2

  puts "== #{filename} (%.2f MB)" % size_in_mb

  file = nil

  readtime = Benchmark.measure do
    file = File.read "#{File.dirname __FILE__}/fixtures/#{filename}"
  end

  parsetime = Benchmark.measure do
    GreenButtonData::Feed.parse file
  end

  total_size += size
  total_parsetime += parsetime.real

  puts "  -> File Read (%.4fs)" % readtime.real
  puts "  -> Parser (%.4fs)" % parsetime.real
  puts "  => Total (%.4fs)" % (readtime.real + parsetime.real)
end

total_size_in_mb = total_size / 1024.0 ** 2
size_parsed_per_sec = total_size_in_mb / total_parsetime

puts "\n=> Total %.2f MB parsed in %.4f seconds (Avg: %.2f MB/s)" % [
  total_size_in_mb,
  total_parsetime,
  size_parsed_per_sec
]
