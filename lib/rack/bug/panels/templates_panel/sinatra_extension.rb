if defined?(Sinatra) && defined?(Sinatra::Templates)
  Sinatra::Templates.class_eval do
    def render_with_rack_bug(engine, template, *args, &block)
      Rack::Bug::TemplatesPanel.record(template) do
        render_without_rack_bug(engine, template, *args, &block)
      end
    end

    alias_method_chain :render, :rack_bug
  end
end

