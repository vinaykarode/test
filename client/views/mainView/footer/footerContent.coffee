Template.footerContent.rendered = ->
    fview = FView.byId 'b1'
    button = fview.surface
    button.on "click",=>
        App.events.emit 'swipeLeft','home'
        button.addClass 'hide'
        
    App.events.on 'swipeLeft',(c)->
        if c isnt 'home'
            button.removeClass 'hide'