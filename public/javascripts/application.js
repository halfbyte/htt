// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Event.observe(window, 'load', function(e) {
  if ($('time')) {
    new Form.Element.Observer(
      'time',
      0.2,
      function(el, value) {
        
        single_time_value = value.match(/\d+[:\.]\d+/)
        has_range = value.match(/-/)
        
        double_time_value = value.match(/(\d+[:\.]\d+).*?-.*?(\d+[:\.]\d+)/)
        
        if (value == "")
          $('parsed_time').update("ab jetzt, offen")
        else if (double_time_value)
          $('parsed_time').update(double_time_value[1] + " BIS " + double_time_value[2])
        else
          if (single_time_value) {
            var erg = single_time_value[0]
            if (has_range)
              erg += " offen"
            $('parsed_time').update(erg)
          }
            
      }
    )
  }
  
})
