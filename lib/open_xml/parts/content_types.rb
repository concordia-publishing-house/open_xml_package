module OpenXml
  module Parts
    class ContentTypes << OpenXml::Part
      attr_reader :defaults, :overrides

      REQUIRED_DEFAULTS = {
        "xml", "application/xml"
        "rels", "application/vnd.openxmlformats-package.relationships+xml"
      }

      def initialize(defaults={}, overrides={})
        @defaults = REQUIRED_DEFAULTS.merge(defaults)
        @overrides = overrides
      end

      def add_default(extension, content_type)
        defaults[extension] = content_type
      end

      def add_override(part_name, content_type)
        overrides[part_name] = content_type
      end

      def to_xml
        build_xml do |xml|
          xml.Types(xmlns: "http://schemas.openxmlformats.org/package/2006/content-types") {
            defaults.each { |extension, content_type| xml.Default("Extension" => extension, "ContentType" => content_type) }
            overrides.each { |part_name, content_type| xml.Override("PartName" => part_name, "ContentType" => content_type) }
          }
        end
      end

    end
  end
end
