if defined?(Sinatra) && defined?(Sinatra::Templates)
  Sinatra::Templates.class_eval do

    [:erb, :erubis, :haml, :sass, :less, :builder].each do |meth|
      class_eval <<-END
        def #{ meth }_with_rack_bug(template, *args, &block)
          Rack::Bug::TemplatesPanel.record(template) do
            #{ meth }_without_rack_bug(template, *args, &block)
          end
        end
      END

      alias_method_chain meth, :rack_bug
    end
  end
end

