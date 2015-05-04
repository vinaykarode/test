Template.footerContent.rendered = ->
    fview = FView.byId 'b1'
    button = fview.surface
    button.on "click",=>
        App.events.emit 'swipeLeft','home'
        console.log "app event swipeleft initiated"
        button.addClass 'hide'
        
    App.events.on 'swipeLeft',(c)->
        console.log "from footerconent c is" + {c}
        if c isnt 'home'
            button.removeClass 'hide'