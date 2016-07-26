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
        prettify? ? prettify(data) : data
      end
  
      def include_blank
        options.fetch(:include_blank, false)
      end
    
      private

      def convert item
        return [prettify(item), item] if prettify?
        return [I18n.t(item), item] if i18n?
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
    end
  end
end
