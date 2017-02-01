require 'test_helper'

class CspBuilderTest < Minitest::Test
  test 'defines a version number' do
    refute_nil ::CspBuilder::VERSION
  end

  test 'fetch directives' do
    csp = CspBuilder.new.
      default_src('*').
      img_src(:self, 'data:').
      script_src(:'unsafe-inline', :'unsafe-eval').
      worker_src('https://cdn.com')

    assert_equal(
      "default-src *; img-src 'self' data:; script-src 'unsafe-inline' 'unsafe-eval'; worker-src https://cdn.com",
      csp.compile!)
  end

  test 'value directives' do
    csp = CspBuilder.new.
      base_uri(:self).
      frame_ancestors('https://a.embed.io', 'https://b.embed.io').
      report_uri('https://api.reporter.com/csp')

    assert_equal(
      "base-uri 'self'; frame-ancestors https://a.embed.io https://b.embed.io; report-uri https://api.reporter.com/csp",
      csp.compile!)
  end

  test 'meta directives' do
    csp = CspBuilder.new.
      block_all_mixed_content.
      upgrade_insecure_requests

    assert_equal(
      "block-all-mixed-content; upgrade-insecure-requests",
      csp.compile!)
  end

  test 'all the directive types' do
    csp = CspBuilder.new.
      default_src(:self).
      base_uri(:self).
      upgrade_insecure_requests

    assert_equal(
      "default-src 'self'; base-uri 'self'; upgrade-insecure-requests",
      csp.compile!)
  end

  test 'directive method with nil' do
    csp = CspBuilder.new.
      default_src(nil)

    assert_equal 'default-src ', csp.compile!
  end

  test 'compile! returns result' do
    csp = CspBuilder.new.default_src(:self)

    assert_equal csp.compile!, csp.result
  end

  test 'compile! freezes object' do
    csp = CspBuilder.new.default_src(:self)
    csp.compile!

    assert_raises RuntimeError do
      csp.script_src('*')
    end
  end

  test 'compiled? before compiling' do
    assert_equal false, CspBuilder.new.compiled?
  end

  test 'compiled? after compiling' do
    assert_equal true, CspBuilder.new.tap(&:compile!).compiled?
  end
end
