window.Clf005 =
  Wizard: {}
  
class Clf005.Wizard.Widgets

Clf005.Wizard.Widgets.calendar = (selector) ->
    #dcv;20130116; console.log("register_calendar for: " + selector)
    if(arguments.length < 1)
      selector = ".wizard-calendar"

    currentYear = new Date().getFullYear()

    $( selector ).datepicker(
      yearRange: String(currentYear-150)+":"+String(currentYear)
      changeMonth: true
      changeYear: true
      dateFormat: "yy-mm-dd"
    )

    $( selector ).each( (i, obj)->
      md = $(obj).val().match(/^(\d{4}-\d{2}-\d{2})/)

      if(md)
        $(obj).val(md[1])
    )


Clf005.Wizard.Widgets.get_partial = (href, response_target) ->
  $.get(href, "load_style=partial", (data) ->
    $(response_target).html(data)
  )
   
Clf005.Wizard.Widgets.post_partial = (href, response_target, form_data) ->
  $.post(href, form_data + "&load_style=partial", (data) ->
    $(response_target).html(data)
  ).error( ->
    $(response_target).html(data)
  )
   
#$wizard_widgets = Clf004.Wizard.Widgets.new()
