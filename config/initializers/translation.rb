TranslationIO.configure do |config|
    config.api_key        = 'b424ee7d6c614a6fa3671977220fee1f'
    config.source_locale  = 'en'
    config.target_locales = ['pt-BR']
  
    # Uncomment this if you don't want to use gettext
    # config.disable_gettext = true
  
    # Uncomment this if you already use gettext or fast_gettext
    # config.locales_path = File.join('path', 'to', 'gettext_locale')
  
    # Find other useful usage information here:
    # https://github.com/translation/rails#readme
  end