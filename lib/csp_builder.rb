require 'csp_builder/version'
require 'csp_builder/constants'

# Content Security Policy builder class. This class provides a lot
# of methods for making it easier to compose Content Security Policies
# for your web applications.
#
# @example Creating a CSP string
#   csp = CspBuilder.new.
#     script_src("https://*.cloudfront.net", :self).
#     style_src("https://*.cloudfront.net").
#     img_src('*').
#     frame_ancestors(:self).
#     upgrade_insecure_requests
#
#   # Get the compiled CSP string:
#   # "script-src https://*.cloudfront.net 'self'; style-src https://*.cloudfront.net; img-src *; frame-ancestors 'self'; upgrade-insecure-requests"
#   csp.compile!
class CspBuilder
  # Final result string. This is set when +compile!+ is called
  attr_reader :result

  # Returns a new instance of +CspBuilder+
  def initialize
    @directives = {}
  end

  # Returns whether the result has been compiled yet
  # @return [Boolean]
  def compiled?
    !@result.nil?
  end

  # Compile CSP string
  # @return [String] resulting CSP string
  def compile!
    @directives.freeze unless @directives.frozen?

    @result ||= compile.freeze
  end

  # @!macro [new] method_doc
  #   Generated method
  #   @param values [Array<String, Symbol>] one or more value; Symbol's are wrapped in single quotes
  #   @return [CspBuilder] self

  # @!method child_src(*values)
  #   @macro method_doc
  # @!method connect_src(*values)
  #   @macro method_doc
  # @!method default_src(*values)
  #   @macro method_doc
  # @!method font_src(*values)
  #   @macro method_doc
  # @!method frame_src(*values)
  #   @macro method_doc
  # @!method img_src(*values)
  #   @macro method_doc
  # @!method manifest_src(*values)
  #   @macro method_doc
  # @!method media_src(*values)
  #   @macro method_doc
  # @!method object_src(*values)
  #   @macro method_doc
  # @!method script_src(*values)
  #   @macro method_doc
  # @!method style_src(*values)
  #   @macro method_doc
  # @!method worker_src(*values)
  #   @macro method_doc
  FETCH_DIRECTIVES.each do |type|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{type}_src(*values)
        values.each { |value| set_directive! :'#{type}-src', value }

        self
      end
    RUBY_EVAL
  end

  # @!method base_uri(*values)
  #   @macro method_doc
  # @!method form_action(*values)
  #   @macro method_doc
  # @!method frame_ancestors(*values)
  #   @macro method_doc
  # @!method plugin_types(*values)
  #   @macro method_doc
  # @!method report_uri(*values)
  #   @macro method_doc
  # @!method require_sri_for(*values)
  #   @macro method_doc
  VALUE_DIRECTIVES.each do |type|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{type.to_s.gsub('-', '_')}(*values)
        values.each { |value| set_directive! :'#{type}', value }

        self
      end
    RUBY_EVAL
  end

  # @!method block_all_mixed_content(*values)
  #   @macro method_doc
  # @!method upgrade_insecure_requests(*values)
  #   @macro method_doc
  META_DIRECTIVES.each do |type|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{type.to_s.gsub('-', '_')}
        @directives[:'#{type}'] = true

        self
      end
    RUBY_EVAL
  end

  private

  # @private
  def compile
    @directives.map { |key, val|
      META_DIRECTIVES.include?(key) ? key.to_s : "#{key} #{val}"
    }.join('; ')
  end

  # @private
  def set_directive!(key, value)
    if Symbol === value
      value = "'#{value}'"
    else
      value = value.dup
    end

    if @directives.has_key? key
      @directives[key] << " "
      @directives[key] << value
    else
      @directives[key] = value
    end
  end
end
