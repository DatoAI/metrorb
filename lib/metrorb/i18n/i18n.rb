module Metrorb
  module I18n
    def self.load_locales!
      locales = ::I18n.available_locales
      yml_pattern = locales.empty? ? '*' : "{#{ locales.join(',') }}"
      ::I18n.load_path.concat(Dir[File.join(File.dirname(__FILE__), 'locales', "#{yml_pattern}.yml")])
    end
  end
end
