Template.appMainView.rendered = ->
    flag = off
    slideDuration = 300
    hdrS = FView.byId('headerS').surface
    ftrS = FView.byId('footerS').surface
    
    hfl = new Famous.Transitionable 0
    
    fview = FView.byId 'hfl'
    
    fview.modifier.transformFrom =>
        currentPosition = hfl.get()
        return Famous.Transform.translate(currentPosition,0,0)
        
    sync = new Famous.GenericSync ['mouse','touch'],{direction:Famous.GenericSync.DIRECTION_X}
    
    #Famous.Engine.pipe sync
    hdrS.pipe sync
    ftrS.pipe sync
    
    sync.on 'end', =>
        if flag is off
            flag = on
            
            if hfl.get() is 0
                hfl.set window.innerWidth - (window.innerWidth*.30), {duration:slideDuration,curve:Famous.Easing.inOutBack}
                FView.byId('backing').modifier.setTransform Famous.Transform.translate(0,0,-10)
            
            else
                hfl.set 0,{duration:slideDuration},=>
                    FView.byId('backing').modifier.setTransform Famous.Transform.translate(0,0,-20)
            
            Meteor.setTimeout ->
                flag=off
            ,200