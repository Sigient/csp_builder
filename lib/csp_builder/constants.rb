class CspBuilder
  # Fetch directive define the locations where various
  # resource types can be loaded from. These directive
  # all end in with "-src"
  FETCH_DIRECTIVES = %i[
    child connect default font frame img
    manifest media object script style worker
  ].freeze

  # Value directives are either document, navigation,
  # reporting or other type of directives that require
  # a value
  VALUE_DIRECTIVES = %i[
    base-uri form-action frame-ancestors
    plugin-types report-uri require-sri-for
  ].freeze

  # Meta directives do not require a value and can be
  # used in a <meta> tag in the document's <head>
  META_DIRECTIVES = %i[
    block-all-mixed-content upgrade-insecure-requests
  ].freeze
end
