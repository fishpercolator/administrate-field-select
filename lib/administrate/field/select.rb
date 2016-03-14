require 'administrate/field/base'

module Administrate
  module Field
    class Select < Base    
      def choices
        options.fetch(:choices, []).
          map { |o| prettify? ? [prettify(o), o] : o }
      end
  
      def to_s
        prettify? ? prettify(data) : data
      end
  
      def include_blank
        options.fetch(:include_blank, false)
      end
    
      private
  
      def prettify?
        !!options[:prettify]
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
