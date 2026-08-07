RubyLLM.configure do |config|
  config.openrouter_api_key = ENV["OPENROUTER_API_KEY"]
  config.default_model = "openai/gpt-4.1-mini"
end
