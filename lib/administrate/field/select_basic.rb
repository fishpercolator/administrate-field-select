require 'administrate/field/base'
require 'rails'

module Administrate
  module Field
    class SelectBasic < Base
      class Engine < ::Rails::Engine
      end

      def choices
        options.fetch(:choices, []).map { |o| convert_to_array(o) }
      end

      def to_s
        convert(data)
      end

      def include_blank
        options.fetch(:include_blank, false)
      end

      private

      def convert_to_array item
        return item if do_not_modify_contents?
        item.respond_to?(:each) ? [convert(item.first), item.last] : [convert(item), item]
      end

      def convert item
        return prettify(item) if prettify?
        return internationalise(item) if i18n?
        return item
      end

      def do_not_modify_contents?
        !(prettify? || i18n?)
      end

      def prettify?
        !!options[:prettify]
      end

      def i18n?
        !!options[:i18n]
      end

      def callable_prettify?
        options[:prettify].respond_to? :call
      end

      def prettify(str)
        callable_prettify? ? options[:prettify].call(str) : str.titleize
      end

      def internationalise item
        return I18n.t(item)
      end
    end
  end
end
