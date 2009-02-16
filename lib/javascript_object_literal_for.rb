module ZepFrog
    module JavaScriptObjectLiteralFor #:nodoc:

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def javascript_object_literal_for
          include ZepFrog::JavaScriptObjectLiteralFor::InstanceMethods
          extend ZepFrog::JavaScriptObjectLiteralFor::SingletonMethods
        end
      end

      module SingletonMethods
        # Add class methods here
      end

      module InstanceMethods

        # TODO provide a way to set the name of the ZEP variable 
        def serialize_to_json(*list)
          js = ""
          js << "<script type=\"text/javascript\">"
          js << "\n\tif (typeof ZEP !== 'object') { var ZEP = {}; }\n"
          js << "\n\tif (typeof ZEP.models !== 'object') { ZEP.models = {}; }\n"
          list.each do |obj|
            if obj.respond_to? :to_json
              js << "\tZEP.models.#{obj.class.to_s.downcase} = " + obj.to_json + ";\n" unless obj.nil?
            end
          end
          js << "</script>"
        end

      end
    end
  end

