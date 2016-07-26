require 'administrate/field/base'
require 'rails'

module Administrate
  module Field
    class SelectBasic < Base
      class Engine < ::Rails::Engine
      end      
      
      def choices
        options.fetch(:choices, []).map { |o| convert(o) }
      end
  
      def to_s
        convert(data, raw: true)
      end
  
      def include_blank
        options.fetch(:include_blank, false)
      end
    
      private

      def convert item, raw: false
        return [prettify(item), item] if prettify? && !raw
        return prettify(item) if prettify? && raw
        return internationalise(item, raw: raw) if i18n?
        return item
      end
  
      def prettify?
        !!options[:prettify]
      end

      def i18n?
        !!options[:i18n]
      end
  
      def prettify(str)
        if options[:prettify].respond_to? :call
          options[:prettify].call(str)
        else
          str.titleize
        end
      end

      def internationalise item, raw: false
        return I18n.t(item) if raw
        item.respond_to?(:each) ? [I18n.t(item.first), item.last] : [I18n.t(item), item]
      end
    end
  end
end
