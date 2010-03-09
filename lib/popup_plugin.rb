# PopupPlugin

module PopupPlugin 
  module Helper
    
    def link_to_popup(text, options = {}, html_options = {}, source = params[:popup_source], target = params[:popup_target])
      link_to_remote(text, { :url => { :popup_source => source, :popup_target => target }.merge(options), :update => source, :before => open_popup(source) } , html_options )
    end

    def link_to_image_popup(src, options = {}, html_options = {}, source = params[:popup_source], target = params[:popup_target] )
      link_to_remote( (image_tag src), { :url => { :popup_source => source, :popup_target => target }.merge(options), :update => source, :before => open_popup(source) } , html_options )
    end
  
    def link_to_close_popup(text, html_options = {}, source = params[:popup_source], target = params[:popup_target])
      link_to_function(text, close_popup(source), html_options)
    end

    def close_popup(target = 'popup')
      "document.body.removeChild(document.getElementById(\"#{target}_popup_background\"));     document.body.removeChild(document.getElementById(\"#{target}\"));"
    end
  
    def open_popup(target = 'popup')
      "
      window.scrollTo(0,0);     background_popup = document.createElement(\"div\");
      background_popup.id = \"#{target}_popup_background\"
      background_popup.className = \"popup_background\";
      document.body.appendChild(background_popup);
      popup = document.createElement(\"div\");
      popup.className = \"popup\";
      popup.id = \"#{target}\";
      popup.style.display = \"block\";
      document.body.appendChild(popup);"
    end
  
    def popup_form_tag(options = {}, html_options = {}, position = nil, source = params[:popup_source], target = params[:popup_target] )
      actual_options = { :url => options, :html => html_options }
      actual_options.merge!(close_options(position, source, target))
      form_remote_tag actual_options
    end
  
    def popup_link_to_remote(text, options = {}, html_options = {}, position = nil, source = params[:popup_source], target = params[:popup_target])

      options.merge!(close_options(position, source, target))
      link_to_remote text, options, html_options
    end

    def close_options(position = nil, source = params[:popup_source], target = params[:popup_target] )
      options = {}
      if source
        script = close_popup(source)
        script += ";window.location.reload()" unless target
        options.merge!({:success => script })
      end
      if target
        options.merge!({:update => target, :position => position})
      end
      options
    end  

  end #Helper

end #PopupPlugin
