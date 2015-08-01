RSpec::Matchers.define :warn do |message|
  match do |block|
    output = fake_stderr(&block)
    output.include? message
  end

  description do
    "write \"#{message}\" to standard error"
  end

  failure_message do
    "expected to #{description}"
  end

  failure_message_when_negated do
    "expected to not #{description}"
  end

  def fake_stderr
    original_stderr = $stderr
    $stderr = StringIO.new
    yield
    $stderr.string
  ensure
    $stderr = original_stderr
  end

  def supports_block_expectations?
    true
  end
end
